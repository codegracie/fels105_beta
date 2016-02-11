class Admin::WordsController < AdminController
  def index
    @words = Word.paginate page: params[:page], per_page: 10
  end

  def show
    @word = Word.find params[:id]
    @word_answers = @word.answers
  end

  def new
    @categories = Category.all
    @word = Word.new
    4.times {@word.answers.build}
  end

  def create
    @word = Word.new word_params
    if @word.save
      redirect_to admin_words_path
    else
      render "new"
    end
  end

  def edit
    @word = Word.find params[:id]
    @categories = Category.all
  end

  def update
    @word = Word.find params[:id]

    if @word.update_attributes word_params
      redirect_to admin_words_path
    else
      render "edit"
    end
  end

  def destroy
    @word = Word.find params[:id]
    @word.destroy

    redirect_to admin_words_path
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:id, :word_id, :content, :correct, :_destroy]
  end
end
