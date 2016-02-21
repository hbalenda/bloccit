class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  before_save { self.email = email.downcase }
#sets default role to member
  before_save { self.role ||= :member }

#sets up accepted characters and format for email
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, length: {minimum: 1, maximum: 100 }, presence: true
#validates password by ensuring password is present, and that if updated length is still 6+
#allow_blank lets user skip password change when updating
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: {minimum: 6 }, allow_blank: true
#validate email is present, unique, and properly formatted.
  validates :email,
      presence: true,
      uniqueness: { case_sensitive: false },
      length: { minimum: 3, maximum: 100 },
      format: { with: EMAIL_REGEX }

#contains methods to set and authenticate against a BCrypt password
#requires password_digest attribute which is set in User model
  has_secure_password
  enum role: [:member, :admin]

  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def has_posts?
    posts.count > 0
  end

  def has_comments?
    comments.count > 0
  end

  def has_favorites?
    favorites.count > 0
  end
end
