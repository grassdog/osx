dep "all fonts installed" do

end

dep 'user font dir exists' do
  met? {
    "~/Library/Fonts".p.dir?
  }
  meet {
    log_shell "Creating ~/Library/Fonts", "mkdir ~/Library/Fonts"
  }
end

meta 'ttf' do
  accepts_list_for :source
  accepts_list_for :extra_source
  accepts_list_for :ttf_filename

  template {
    requires 'user font dir exists'
    prepare {
      setup_source_uris
    }
    met? {
      "~/Library/Fonts/#{ttf_filename.first}".p.exists?
    }
    meet {
      process_sources do
        Dir.glob("*.ttf") do |font|
          log_shell "Installing #{font}", "cp #{font} ~/Library/Fonts"
        end
      end
    }
  }
end

meta 'otf' do
  accepts_list_for :source
  accepts_list_for :extra_source
  accepts_list_for :otf_filename

  template {
    requires 'user font dir exists'
    prepare {
      setup_source_uris
    }
    met? {
      "~/Library/Fonts/#{otf_filename.first}".p.exists?
    }
    meet {
      process_sources do
        Dir.glob("*.otf") do |font|
          log_shell "Installing #{font}", "cp #{font} ~/Library/Fonts"
        end
      end
    }
  }
end

# TODO Setup font install here

dep 'meslo.ttf' do
  source 'http://github.com/downloads/andreberg/Meslo-Font/Meslo%20LG%20DZ%20v1.0.zip'
  ttf_filename "MesloLGM-DZ-Regular.ttf"
end

dep 'crimson.otf' do
  source 'http://internode.dl.sourceforge.net/project/crimsontext/crimson_101217.zip'
  otf_filename "Crimson-Roman.otf"
end

dep 'ROKE1984.otf' do
  otf_filename "ROKE1984.otf"
  meet {
    `curl http://dl.dropbox.com/u/2971204/ROKE1984.otf > ~/Library/Fonts/ROKE1984.otf`
  }
end
