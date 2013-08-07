
actions :create, :delete
default_action :create

attribute :nickname,
  :kind_of => String,
  :name_attribute => true
attribute :bind_to,
  :kind_of => [String, Integer],
  :required => true
attribute :forward_to,
  :kind_of => String,
  :required => true
attribute :via,
  :kind_of => String,
  :required => true

attribute :identity_file,
  :kind_of => String
attribute :identity,
  :kind_of => String
attribute :identity_root,
  :kind_of => String,
  :default => '/root/.autossh'

attribute :upstart_cookbook,
  :kind_of => String,
  :default => 'autossh'
attribute :upstart_template,
  :kind_of => String,
  :default => 'upstart.conf.erb'

attribute :ssh_options,
  :kind_of => Array,
  :default => []

attribute :bind,
  :kind_of => String,
  :equal_to => ["locally", "remotely"],
  :default => "locally"

