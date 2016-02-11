class AdminController < ApplicationController
  layout "admin"
  before_action :correct_user

  private
  def correct_user
    redirect_to login_path unless current_user&.admin?
  end
end