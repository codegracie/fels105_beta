class HomeController < ApplicationController
  def index
    if logged_in?
      @activities = current_user.feeds.paginate page: params[:page], per_page: 15
      @sets = UserSet.where("recommended = ?", true).all
      @new_sets = UserSet.last 5
      @set_lessons = current_user.set_lessons
    end
  end
end