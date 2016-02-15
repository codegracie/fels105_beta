class UsersController < ApplicationController

  def index
    if params[:search]
      @users = User.paginate(page: params[:page]).search(params[:search]).order("created_at DESC")
    else
      @users = User.paginate page: params[:page], per_page: 20
    end
  end

  def show
    @user_set_types = {"Everyone": "1","Friends only": "2","Only me": "3"}
    @categories = Category.all
    @user = User.find params[:id]
    @user_set = @user.user_sets.build
    @user_sets = @user.user_sets
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      # @user.send_activation_email
      # flash[:info] = t ".info"
      # redirect_to root_url
      @user.update_attributes activated: true, activated_at: Time.zone.now
      login @user
      redirect_to user_path @user
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