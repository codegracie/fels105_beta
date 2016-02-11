class HomeController < ApplicationController
  def index
    if logged_in?
      @activities = current_user.feeds.paginate page: params[:page], per_page: 15
    end
  end
end