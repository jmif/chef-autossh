# autossh cookbook

Install and configure auto-starting autossh tunnels using upstart.

# Requirements

 - ubuntu

# Usage

Check out recipes/example.rb for various usages... However, the following code
is a good basic example. Since there appears to be much confusion on how
exactly this works, here is an in-depth example and description:

```ruby
autossh "datacenter-a-to-datacenter-b" do
  bind_to "192.168.1.12:443"
  forward_to "10.10.10.10:443"
  via "jumphostuser@datacenter-b-jumphost"

  # if you have the key in node data
  identity "private-key-goes-here"

  # if you have the key on disk
  identity_file "my-private-key"
  identity_root "/path/too/directory/containing/key"
end
```
If you were to run this resource on `machine-a` in `datacenter-a`, it would:

1. open an SSH connection to datacenter-b-jumphost using the account
   `jumphostuser`.
2. bind to the `192.168.1.12` interface, with port 443, on `machine-a`, and
   accept incoming traffic.
3. transfer the incoming data to `datacenter-b-jumphost`
4. send the traffic out of `datacenter-b-jumphost`'s network interface, to that
   network's `10.10.10.10:443` service.

To be more succinct, from `datacenter-a`, you could run
`wget https://192.168.1.12/foo/bar` and it will be forwarded to
`10.10.10.10:443` in `datacenter-b`, and the response will be returned to
`datacenter-a`.

# Attributes

none

# Recipes

 - default - no actions taken.
 - example - assorted use cases, and an awful way to test that its working.
   If you want to contribute, making this use test-kitchen would be great - I
   could not get it working.

# Author

Author:: Graham Christensen (<graham@zippykid.com>)

