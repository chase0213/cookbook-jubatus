require 'poise'

class Chef
  # Chef provider for installing and removing jubatus from package
  class Provider::JubatusInstallPackage < Provider
    include Poise
    include JubatusCookbook::Helpers
    provides :jubatus_install, platform_family: %w( rhel amazon ) if respond_to?(:provides)

    def action_install
      converge_by("#{new_resource.name} - install package") do
        notifying_block do
          package_url = get_package_url(new_resource, node)
          filename = package_url.split('/').last
          package_options = new_resource.package_options
          package_role = new_resource.package_role

          download_package(package_url, "#{Chef::Config[:file_cache_path]}/#{filename}")
          install_repo("#{Chef::Config[:file_cache_path]}/#{filename}")
          install_package(package_role, package_options)
        end
      end
    end

    def action_remove
      converge_by("#{new_resource.name} - remove package") do
        notifying_block do
          package_url = get_package_url(new_resource, node)
          filename = package_url.split('/').last
          package_role = new_resource.package_role

          remove_package(package_role)
          remove_repo("#{Chef::Config[:file_cache_path]}/#{filename}")
        end
      end
    end

    class << self
      def supports?(resource, action)
        resource.type == :package
      end
    end

    protected

    def download_package(url, path)
      remote_file path do
        source url
        mode 0644
      end
    end

    def install_repo(path)
      package path do
        action :install
      end
    end

    def install_package(package_role, package_options)
      package package_role do
        options package_options
        action :install
      end
    end

    def remove_repo(path)
      package path do
        action :remove
      end
    end

    def remove_package(package_role)
      package package_role do
        action :remove
      end
    end
  end
end
