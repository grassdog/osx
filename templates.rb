meta "mkdir" do
  accepts_list_for :base
  accepts_value_for :target

  template {
    def target_directories
      base.map { |b| b / target }
    end

    met? {
      target_directories.all? { |td| td.p.dir? }
    }
    meet {
      target_directories.each do |td|
        sudo "mkdir -p #{td}"
      end
    }
  }
end

meta "dir" do
  accepts_value_for :path, :basename
  template {
    met? { path.p.dir? }
    meet { log_shell "Creating #{path}", "mkdir -p #{path}" }
  }
end

meta "symlink" do
  accepts_value_for :source
  accepts_value_for :target

  template {
    met? { target.p.readlink == source }
    meet { sudo "ln -s '#{source}' '#{target}'" }
  }
end

meta "render" do
  accepts_value_for :target
  accepts_value_for :erb

  template {
    def erb_path
      dependency.load_path.parent / erb
    end

    met? { Babushka::Renderable.new(target).from?(erb_path) }
    meet {
      render_erb erb_path, :to => target, :sudo => true
    }
  }
end

meta "file" do
  accepts_value_for :source
  accepts_value_for :name, :basename
  accepts_value_for :target

  template {

    met? { target.p.exist? }

    meet {
      Babushka::Resource.extract(source) { |archive|
        log_shell "Copying #{name} to #{target}", "cp -R **/#{name} #{target}"
      }
    }
  }
end

meta :repo do
  accepts_value_for :source
  accepts_value_for :path

  template {
    def repo
      @repo ||= Babushka::GitRepo.new(path).tap do |r|
        r.repo_shell('git fetch') if r.exists?
      end
    end

    meet do
      if repo.exists?
        log_block "Updating to #{repo.current_remote_branch} (#{repo.resolve(repo.current_remote_branch)})" do
          repo.reset_hard!(repo.current_remote_branch)
        end
      else
        git source, :to => path
      end
    end
    met? { repo.exists? && !repo.behind? }
  }
end
