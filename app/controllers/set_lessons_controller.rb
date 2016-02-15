class SetLessonsController < ApplicationController

  def edit
    @lesson = SetLesson.find params[:id]
  end

  def update
    @lesson = SetLesson.find params[:id]
    if @lesson.update_attributes lesson_params
      @lesson.create_activity
      flash.now[:success] = t ".finish"
      redirect_to root_path
    else
      redirect_to edit_set_lesson_path @lesson
    end
  end

  def create
    if SetLesson.exists? user_id: current_user.id, user_set_id: params[:user_set_id]
      @set_lesson = SetLesson.where("user_id = ? and user_set_id = ?", current_user.id, params[:user_set_id]).first
    else
      @set_lesson = SetLesson.create user: current_user, user_set_id: params[:user_set_id]
    end
    flash.now[:success] = t ".start"
    redirect_to edit_set_lesson_path @set_lesson
  end

  def destroy
    @lesson = SetLesson.find params[:id]
    @lesson.destroy

    redirect_to root_path
  end

  private
  def lesson_params
    params.require(:set_lesson).permit :user_id, :user_set_id,
      lesson_words_attributes: [:id, :lesson_id, :word_id, :answer_id, :correct]
  end
end