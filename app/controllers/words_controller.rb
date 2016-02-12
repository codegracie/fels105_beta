class WordsController < ApplicationController
respond_to :html, :json
  def index
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
end
