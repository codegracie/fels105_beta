class Word < ActiveRecord::Base
  has_many :lesson_words
  has_many :answers, dependent: :destroy
  belongs_to :category
  belongs_to :user_set

  accepts_nested_attributes_for :answers, reject_if:
    lambda {|a| a[:content].blank?}, allow_destroy: true

  validates :content, presence: true

  #<% ["all_words", "learned", "not_learned"].each_with_index do |option, index| %>
  #scope :all_words, ->user_id{}
  



  def self.search search
    where("content LIKE ?", "%#{search}%")
  end

end