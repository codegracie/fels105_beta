class Admin::UserSetsController < AdminController
  def index
    @user_sets = UserSet.all
  end

  def show
    @user_set = UserSet.find params[:id]
    @user_set_words = @user_set.words
  end

  def edit
    @user_set = UserSet.find params[:id]
  end

  def edit
    @user_set = UserSet.find params[:id]
    @user_set_types = {"Everyone": "1","Friends only": "2","Only me": "3"}
    @categories = Category.all
  end

  def update
    @user_set = UserSet.find params[:id]
    if @user_set.update_attributes user_set_params
      redirect_to admin_user_sets_path
    else
    end
  end

  def destroy
    @user_set = UserSet.find params[:id]
    @user_set.destroy
    redirect_to admin_user_sets_path
  end

  private
  def user_set_params
    params.require(:user_set).permit :title, :description, :set_type,
      :user_id, :category_id, :recommended, words_attributes: [:id, :category_id, :content, :_destroy,
      answers_attributes: [:id, :word_id, :content]]
  end
end