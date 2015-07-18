require 'poise'

class Chef
  # Chef resource for declaring a user and group for Jubatus
  class Resource::JubatusUser < Resource
    include Poise

    actions(:create, :remove)
    default_action :create

    attribute(:username, kind_of: String, default: lazy { name })
    attribute(:uid, kind_of: Integer)
    attribute(:shell, kind_of: String, default: '/bin/bash')
    attribute(:comment, kind_of: String, default: 'Jubatus User')

    attribute(:homedir_name, kind_of: String, default: lazy { username })
    attribute(:homedir_parent, kind_of: String, default: '/opt')
    attribute(:homedir, kind_of: String, default: lazy { ::File.join(homedir_parent, homedir_name) })

    attribute(:groupname, kind_of: String, default: lazy { username })
    attribute(:gid, kind_of: Integer)
  end
end
