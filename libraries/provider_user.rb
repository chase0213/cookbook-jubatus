require 'poise'

class Chef
  # Chef provider for creating a user and group for Jubatus
  class Provider::JubatusUser < Provider
    include Poise
    
    def action_create
      converge_by("create jubatus_user resource #{new_resource.name}") do
        notifying_block do
          group new_resource.groupname do
            gid new_resource.gid
            action :create
            system true
          end

          user new_resource.username do
            comment  new_resource.comment
            home     new_resource.homedir
            shell    new_resource.shell
            uid      new_resource.uid
            gid      new_resource.groupname
            supports manage_home: false          
            action   :create
            system   true
          end

          bash 'remove the home directory for jubatus' do
            user    'root'
            code    "rm -rf #{new_resource.homedir}"
            not_if  { ::File.symlink?("#{new_resource.homedir}") }
            only_if { ::File.directory?("#{new_resource.homedir}") }
          end
        end
      end
    end

    def action_remove
      converge_by("remove jubatus_user resource #{new_resource.name}") do
        notifying_block do
          # delete user before deleting the group
          user new_resource.username do
            action :remove
          end

          group new_resource.groupname do
            action :remove
          end
        end
      end
    end
  end
end