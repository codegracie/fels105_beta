class WordsController < ApplicationController
 
  def index
    respond_to do |format|
      @categories = Category.all
      if params[:search]
        @words = Word.paginate(page: params[:page]).search(params[:search]).order("created_at DESC")
      else
        @words = Word.paginate page: params[:page], per_page: 20
      end
       
       format.html
       format.json
       format.json do
          render json: @words, status: :ok
       end
     end
  end

  def show
    @word = Word.find params[:id]
    @word_answers = @word.answers
  end

end


  

  