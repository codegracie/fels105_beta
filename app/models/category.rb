class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words
  validates :name, :description, presence: true
  mount_uploader :picture, PictureUploader
end