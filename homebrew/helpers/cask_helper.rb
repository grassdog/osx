# A PkgHelper for managing Homebrew Cask packages
class CaskHelper < Babushka::BrewHelper
  class << self
    def pkg_cmd; 'brew cask' end
    def manager_dep; 'homebrew-cask' end
    def pkg_type; :cask end
    def manager_key; :cask end

    # The default implementation uses "which pkg_binary" to check if
    # this package manager is present. Since Homebrew Cask is an add-on
    # to Homebrew, it's necessary to check if the relevant package is
    # installed in Homebrew.
    def present?
      Babushka::BrewHelper.has? cask_package_name
    end

    # Delegate prefix to Homebrew helper
    def prefix
      Babushka::BrewHelper.prefix
    end

    # The name of the Homebrew package to install Homebrew Cask itself
    def cask_package_name
      'brew-cask'
    end

    def all_versions_of pkg
      pkg_name = pkg.respond_to?(:name) ? pkg.name : pkg
      Dir[
        installed_pkgs_path / pkg_name / '*'
      ].map {|i|
        File.basename i.chomp('/')
      }.map(&:to_s)
    end

    # The path where the brew-cask package has been installed
    #
    # e.g.: "/usr/local/Cellar/brew-cask/0.25.0"
    def cask_prefix
      Babushka::BrewHelper.brew_path_for cask_package_name
    end

    # The place where Homebrew casks are installed.
    #
    # Currently this uses the default caskroom for Homebrew Cask, which
    # is "/opt/homebrew-cask/Caskroom".
    #
    # TODO: make this determine the real caskroom
    def caskroom
      "/opt/homebrew-cask/Caskroom".p
    end


    private
      # Don't check versions
      def has_pkg? pkg
        all_versions_of(pkg).any?
      end

      # The default implementation is "brew cask update", but Homebrew
      # Cask doesn't have its own explicit "update" operation, it just
      # uses Homebrew's standard update.
      def pkg_update_command
        "brew update"
      end

      # Homebrew Cask can't install a particular version on the CLI,
      # so we need to remove the --version flag from the default
      # implementation.
      def cmdline_spec_for pkg
        pkg.name
      end

      def has_formula_for? pkg
        existing_formulas.include? pkg.name
      end

      # Include multiple formulas paths (from taps)
      def existing_formulas
        formulas_paths.map {|path|
          Dir[path / '*.rb'].map {|i| File.basename i, '.rb' }
        }.flatten.uniq
      end

      # Homebrew Cask packages get installed in the "caskroom"
      def installed_pkgs_path
        caskroom
      end

      # The path to Homebrew's "Taps" directory
      def taps_path
        prefix.p / 'Library' / 'Taps'
      end

      # The path where Cask formulae are kept
      #
      # e.g.: "/usr/local/Cellar/brew-cask/0.25.0/Casks"
      def formulas_paths
        [
          cask_prefix / 'Casks',
          Dir[taps_path / '*' / 'Casks'].map(&:p),
        ].flatten
      end
  end
end

Babushka::PkgHelper.all_manager_keys << CaskHelper.manager_key
