class UserSet < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :words
  has_many :set_lessons

  validates :title, presence: true
  validates :category, presence: true
  validates :set_type, presence: true

  accepts_nested_attributes_for :words, reject_if:
    lambda {|a| a[:content].blank?}, allow_destroy: true
end