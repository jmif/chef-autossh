
action :create do
  # Fetch current values
  nick             = new_resource.nickname
  local            = new_resource.bind_to
  remote           = new_resource.forward_to
  via              = new_resource.via

  id_file          = new_resource.identity_file
  id               = new_resource.identity
  id_root          = new_resource.identity_root

  upstart_cookbook = new_resource.upstart_cookbook
  upstart_template = new_resource.upstart_template

  ssh_opts         = new_resource.ssh_options
  ssh_bind_dir     = new_resource.bind

  # Update attributes for convenience
  target_id_file = id_root + "/" + (id_file || nick)
  local_opts = []
  local_opts += ssh_opts

  bind_direction = ssh_bind_dir == "locally" ? "-L" : "-R"

  # Install dependencies
  package "autossh-%s" % nick do
    package_name "autossh"
  end

  # Given we have an identity to place, place it.
  if id
    directory "root-for-autossh-%s" % nick do
      path id_root
    end

    Chef::Log.debug('autossh:create - placing ID file at %s' % target_id_file)
    file target_id_file do
      content id
    end
  end


  if target_id_file
    local_opts.unshift( '-i %s' % target_id_file)
  end

  generated_command = "autossh -N %s %s:%s %s %s" % [
    bind_direction,
    local,
    remote,
    via,
    local_opts.join(" ")
  ]


  # Write out the upstart configuration
  template "/etc/init/autossh-%s.conf" % nick do
    cookbook upstart_cookbook
    source upstart_template
    variables({
      :name => nick,
      :command => generated_command
    })
  end
end
