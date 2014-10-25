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
