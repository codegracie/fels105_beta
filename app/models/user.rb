class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessor :remember_token, :activation_token

  has_many :lessons, dependent: :destroy
  has_many :activities, as: :log
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id,
    dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id,
    dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships
  has_many :user_sets, dependent: :destroy
  has_many :set_lessons, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 50},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  before_save   :downcase_email
  before_create :create_activation_digest

  def self.search search
    where("first_name LIKE ?", "%#{search}%")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def feeds
    following_ids = self.active_relationships.pluck :followed_id
    following_ids << id
    Activity.followed following_ids
  end

  def total_words_learned_content
    @total_learned = []
    lessons.map{|lesson|
      lesson.list_of_correct_answer.map{|lesson_word|
        @total_learned << lesson_word.word_id
      }
    }
    @total_learned.uniq
  end

  def total_words_learned
    @total_learned = []
    lessons.map{|lesson|
      lesson.list_of_correct_answer.map{|lesson_word|
        @total_learned << lesson_word.word_id
      }
    }
    @total_learned.uniq.count
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  private
  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end