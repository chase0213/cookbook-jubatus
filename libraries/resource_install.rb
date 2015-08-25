require 'poise'

class Chef
  # Chef resource for installing or removing Jubatus from package
  class Resource::JubatusInstall < Resource
    include Poise
    provides :jubatus_install

    actions(:install, :remove)
    default_action :install

    attribute(:type, kind_of: Symbol, equal_to: [:package], default: :package)
    # install latest version by default
    attribute(:version, kind_of: String, default: '')

    attribute(:package_url, kind_of: String, default: nil)
    attribute(:package_options, kind_of: String, default: nil)
    attribute(:package_role, kind_of: String, equal_to: %w(jubatus jubatus-client), default: nil)
  end
end
