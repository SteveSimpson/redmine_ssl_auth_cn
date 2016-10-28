RedmineApp::Application.routes.draw do
  root :to => 'account#ssl_login', :force_ssl => true
  get 'login/ssl', :to => 'account#ssl_login', :as  => 'pki_signin', :force_ssl => true
end