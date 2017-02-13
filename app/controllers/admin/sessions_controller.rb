class Admin::SessionsController < AdminController

  def new
  end

  def create
    if Yetting.admin.blank?
      redirect_to new_admin_session_path, notice: t('admin.session.no_configuration')
    elsif Yetting.admin != params[:username]
      redirect_to new_admin_session_path, notice: t('admin.session.username_error')
    elsif Yetting.admin_password != params[:password]
      redirect_to new_admin_session_path, notice: t('admin.session.password_error')
    else
      session[:login] = Yetting.admin_session_login
      redirect_to admin_root_path, notice: t('admin.session.login_success')
    end
  end

  def destroy
    session[:login] = nil
    redirect_to new_admin_session_path, notice: t('admin.session.destroy_success')
  end
end