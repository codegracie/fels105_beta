class WordsController < ApplicationController
 
  def index
    if params[:search]
      @words = Word.paginate(page: params[:page]).search(params[:search]).order("created_at DESC")
    else
      @words = Word.paginate page: params[:page], per_page: 20
    end

    respond_to do |format|
     @categories = Category.all
     #@words = @words.paginate page: params[:page], per_page: 10
       
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


#respond_to :html, :json
 #  def index
 #    respond_to do |format|
 #      @categories = Category.all
 #      #@words = @words.paginate page: params[:page], per_page: 10
       
 #      format.html
 #      format.json
 #      format.json do
 #         render json: @words, status: :ok
 #      end
 #    end
 #  end




end


  

  