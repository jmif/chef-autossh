
# Basic usage:
autossh "local-to-local" do
  bind_to "0.0.0.0:1234"
  forward_to "127.0.0.1:4567"
  via "127.0.0.1"
end

# Specifying an identity file, with an identity should write to that file in
# the default root
autossh "id-with-file" do
  bind_to "0.0.0.0:1234"
  forward_to "127.0.0.1:4567"
  via "127.0.0.1"

  identity_file "foo.id"
  identity "i should be at /root/.autossh/foo.id"
end

# Specifying an identity file, with an identity should write to that file in
# the specified root
autossh "id-with-file-specified-root" do
  bind_to "0.0.0.0:1234"
  forward_to "127.0.0.1:4567"
  via "127.0.0.1"

  identity_file "foo.id"
  identity_root "/tmp/"
  identity "i should be at /tmp/foo.id"
end

# Specifying an identity, without an identity should write to a file based on
# the name
autossh "id-without-id-file" do
  bind_to "0.0.0.0:1234"
  forward_to "127.0.0.1:4567"
  via "127.0.0.1"

  identity "i should be at /root/.autossh/id-without-id-file"
end

# It outputs a upstart configuration for this autossh tunnel
autossh "check-autossh-upstart" do
  bind_to "0.0.0.0:1234"
  forward_to "127.0.0.1:4567"
  via "127.0.0.1"

  identity <<-ID
  The resulting upstart should have a command equal to:
  autossh -L 0.0.0.0:1234:127.0.0.1:4567 127.0.0.1 -i /root/.autossh/check-autossh-upstart
ID
end

# The upstart configuration has additional SSH options
autossh "additional-ssh-options" do
  bind_to "0.0.0.0:1234"
  forward_to "127.0.0.1:4567"
  via "127.0.0.1"
  ssh_options ['--foo=bar', '--baz', '-quux']
  identity <<-ID
  The resulting upstart should have extra options:
   --foo = bar --baz -quux
ID
end

execute "autossh-should-be-installed" do
  command "autossh -V 2>&1 > /dev/null"
end

