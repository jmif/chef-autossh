# autossh cookbook

Install and configure auto-starting autossh tunnels using upstart.

# Requirements

 - ubuntu

# Usage

Check out recipes/example.rb for various usages... However:

```ruby
autossh "datacenter-a-to-datacenter-b" do
  bind_to "0.0.0.0:443"
  forward_to "10.10.10.10:443"
  via "user@datacenter-b-jumphost"

  # if you have the key in node data
  identity "private-key-goes-here"

  # if you have the key on disk
  identity_file "my-private-key"
  identity_root "/path/too/directory/containing/key"
end
```

# Attributes

none

# Recipes

 - default - no actions taken.
 - example - assorted use cases, and an awful way to test that its working.
   If you want to contribute, making this use test-kitchen would be great - I
   could not get it working.

# Author

Author:: Graham Christensen (<graham@zippykid.com>)

