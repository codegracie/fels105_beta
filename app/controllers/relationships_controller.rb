class RelationshipsController < ApplicationController
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

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user

    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user

    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end