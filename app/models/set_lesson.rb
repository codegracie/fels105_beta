class SetLesson < ActiveRecord::Base
  include ApplicationHelper

  has_many :activities, as: :log
  has_many :lesson_words
  belongs_to :user
  belongs_to :user_set

  accepts_nested_attributes_for :lesson_words, allow_destroy: true

  after_create :generate_words

  def list_of_correct_answer
    raise
    @total_correct = lesson_words.select{|lesson_word|
      lesson_word.answer.correct? unless
      lesson_word.answer.nil?}
  end

  def create_activity
    @activity = Activity.create log_id: self.user_id, log_type: "User",
      content: "Update Set in '#{self.user_set.category.name}' -
      #{datetime self.created_at}",
      activity_type: "1"
  end

  private
  def generate_words
    @user_set_words = self.user_set.words.pluck(:id)
    @user_set_words.each do |word_id|
      LessonWord.create set_lesson_id: self.id, word_id: word_id
    end
  end
end