module JubatusCookbook
  module Helpers
    def get_package_url(new_resource, node)
      return new_resource.package_url if new_resource.package_url

      case node['platform_family']
      when 'rhel', 'amazon'
        platform_version = node[:platform_version].to_i
        "http://download.jubat.us/yum/rhel/#{platform_version}/stable/x86_64/jubatus-release-#{platform_version}-2.el#{platform_version}.x86_64.rpm"
      end
    end
  end
end