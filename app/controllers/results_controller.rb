class ResultsController < ApplicationController
  def show
    @lesson = Lesson.find params[:id]
    @lesson_words = @lesson.lesson_words
  end
end