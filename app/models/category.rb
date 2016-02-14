class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words
  has_many :user_sets
  validates :name, :description, presence: true
  mount_uploader :picture, PictureUploader

  def self.search search
    where("name LIKE ?", "%#{search}%")
  end
end