class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_save { self.name = format_name(name) }

#sets up accepted characters and format for email
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
#validates password by ensuring password is present, and that if updated length is still 6+
#allow_blank lets user skip password change when updating
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true
#validate email is present, unique, and properly formatted.
  validates :email,
      presence: true,
      uniqueness: { case_sensitive: false },
      length: { minimum: 3, maximum: 100 },
      format: { with: EMAIL_REGEX }

#contains methods to set and authenticate against a BCrypt password
#requires password_digest attribute which is set in User model
  has_secure_password

  def format_name(name)
    if name
      new = []
      name.split.each {|x| new << x.capitalize }
      new.join(" ")
    end
  end
end
