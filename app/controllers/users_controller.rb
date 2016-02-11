class UsersController < ApplicationController

  def index
    @users = User.paginate page: params[:page], per_page: 20


    @users = User.all
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order('created_at DESC')
    end


  end

  def show
    @user = User.find params[:id]
    @activities = @user.activities.paginate page: params[:page], per_page: 15
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".info"
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    if @user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit :first_name, :last_name, :email,
      :password, :password_confirmation, :avatar
  end
end