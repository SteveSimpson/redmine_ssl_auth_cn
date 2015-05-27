class AccountController < ApplicationController
  def try_ssl_auth
    session[:pki] = request.env["SSL_CLIENT_S_DN_CN"]
    # if SSL_CLIENT_S_DN_CN is not set fallback to HTTP_SSL_CLIENT_S_DN
    if session[:pki].nil? and request.env['HTTP_SSL_CLIENT_S_DN']
      session[:pki] = request.env['HTTP_SSL_CLIENT_S_DN']
    end
    if session[:pki]
      logger.info ">>> Login with certificate common name: " + session[:pki]
      user = User.find_by_login(session[:pki])
      # TODO: try to register on the fly
      unless user.nil?
      # Valid user
      return false if !user.active?
        user.update_attribute(:last_login_on, Time.now) if user && !user.new_record?
        self.logged_user = user
        return true
      end
    end
    return false
  end

  def ssl_login
    if params[:force_ssl]
      if try_ssl_auth
        redirect_back_or_default :controller => 'my', :action => 'page'
        return
      else
        render_403
        return
      end
    end
    if !User.current.logged? and not params[:skip_ssl]
      if try_ssl_auth
        redirect_back_or_default :controller => 'my', :action => 'page'
        return
      end
    end

    login
  end
end
