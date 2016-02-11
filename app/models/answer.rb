class Answer < ActiveRecord::Base
  belongs_to :word
  has_many :lesson_words

  validates :content, presence: true
end