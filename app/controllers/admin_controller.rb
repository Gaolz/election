class AdminController < ApplicationController
  require 'csv'

  def admin_required
    redirect_to new_admin_session_path, alert: t('admin.session.need_login')\
      unless current_admin?
  end
end
