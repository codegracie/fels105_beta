class AddSetLessonToLessonWords < ActiveRecord::Migration
  def change
    add_column :lesson_words, :set_lesson_id, :integer
  end
end
