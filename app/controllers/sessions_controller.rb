class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user and user.authenticate params[:session][:password]
      if user.activated?
        login user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        if user.admin?
          redirect_to admin_root_path
        else
          redirect_back_or user
        end
      else
        message  = t ".not_activated"
        message += t ".check_email"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = t ".invalid"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end