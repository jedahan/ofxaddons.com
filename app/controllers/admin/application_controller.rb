class Admin::ApplicationController < ApplicationController

  layout "admin"

  before_filter :ensure_admin

  def ensure_admin
    redirect_to(root_path) unless @current_user && @current_user.admin?
  end

end