class Word < ActiveRecord::Base
  has_many :lesson_words
  has_many :answers, dependent: :destroy
  belongs_to :category
  belongs_to :user_set

  accepts_nested_attributes_for :answers, reject_if:
    lambda {|a| a[:content].blank?}, allow_destroy: true

  validates :content, presence: true
end