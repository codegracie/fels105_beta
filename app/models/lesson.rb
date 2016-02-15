class Lesson < ActiveRecord::Base
  include ApplicationHelper

  has_many :activities, as: :log
  has_many :lesson_words
  belongs_to :user
  belongs_to :category

  accepts_nested_attributes_for :lesson_words, allow_destroy: true

  after_create :generate_words

  def list_of_correct_answer
    @total_correct = lesson_words.select{|lesson_word|
      lesson_word.answer.correct? unless
      lesson_word.answer.nil?}
  end

  def create_activity
    @activity = Activity.create log_id: self.user_id, log_type: "User",
      content: "Learned #{self.list_of_correct_answer.count} words in
      '#{self.category.name}' - #{datetime self.created_at}",
      activity_type: "1"
  end

  private
  def generate_words
    @category_words = self.category.words.pluck(:id).sample 20
    @category_words.each do |word_id|
      LessonWord.create lesson_id: self.id, word_id: word_id
    end
  end
end