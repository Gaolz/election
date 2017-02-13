class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_admin?

  def current_admin?
    session[:login] == Yetting.admin_session_login
  end
end
