class LessonsController < ApplicationController
  def edit
    @lesson = Lesson.find params[:id]
  end

  def update
    @lesson = Lesson.find params[:id]
    if @lesson.update_attributes lesson_params
      @lesson.create_activity
      flash.now[:success] = t ".finish"
      redirect_to result_path @lesson
    else
      redirect_to edit_lesson_path @lesson
    end
  end

  def create
    @lesson = Lesson.create user: current_user, category_id: params[:category_id]
    flash.now[:success] = t ".start"
    redirect_to edit_lesson_path @lesson
  end

  private
  def lesson_params
    params.require(:lesson).permit :user_id, :category_id,
      lesson_words_attributes: [:id, :lesson_id, :word_id, :answer_id, :correct]
  end
end