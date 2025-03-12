require 'redmine'

Redmine::Plugin.register :redmine_ssl_auth_cn do
  name 'Redmine SSL Auth CN plugin'
  author 'Steve Simpson'
  description 'Enable authentication using SSL client certificates where username=[certificate common name].'
  version '1.0.2'
end
