class Admin::RelationshipsController < AdminController
  def index
    @types = ["followers", "following"]
    @title = t ".title"
    @user  = User.find params[:id]
    if params && @types.include?(params[:type])
      @users = @user.send(params[:type]).paginate page: params[:page], per_page: 10
      render "users/show_follow"
    else
      render file: "public/404.html", status: :not_found, layout: false
    end
  end
end