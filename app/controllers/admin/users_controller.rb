class Admin::UsersController < AdminController
  def index
    @users = User.paginate page: params[:page], per_page: 10
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      redirect_to admin_users_path
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
      redirect_to admin_users_path
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy

    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :first_name, :last_name, :email,
      :password, :password_confirmation, :avatar, :admin
  end
end