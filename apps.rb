dep "vim.managed" do
  meet {
    pkg_manager.install! packages, "--with-ruby --with-mzscheme --with-python"
  }
end

dep "emacs.managed" do
  meet {
    pkg_manager.install! packages, "--srgb --cocoa"
  }
end

# All brews and casks ala https://github.com/quad/osx

parse = -> (l) {
  n, p = l.strip.split(':')
  p = [] if p == '_' # provides nothing
  [n, -> (t) { dep "#{n}.#{t}" do provides p if p end }]
}
brews = File.readlines(File.expand_path '../brews.lst', __FILE__).map &parse
casks = File.readlines(File.expand_path '../casks.lst', __FILE__).map &parse

# Define our deps
brews.each { |n, p| p['managed'] }
casks.each { |n, p| p['cask'] }

dep "all apps installed" do
  requires "vim.managed", "emacs.managed"

  # Require our deps
  brews.each { |n, p| requires "#{n}.managed" }
  casks.each { |n, p| requires "#{n}.cask" }
end
