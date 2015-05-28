require 'redmine'
require 'ext/account_controller'

Redmine::Plugin.register :redmine_ssl_auth do
  name 'Redmine SSL auth plugin where Username is the common name in the certificate.'
  author 'Steve Simpson'
  description 'Enable authentication using SSL client certificates'
  version '0.1.1'
end
