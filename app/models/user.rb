require 'bcrypt'
require 'carrierwave/orm/activerecord'
require 'carrierwave/processing/mini_magick'

PASSWORD_RESET_EXPIRES = 4

class User < ActiveRecord::Base

  has_many :tools_owned, inverse_of: :owner, class_name: "Tool"
  has_many :transactions
  has_many :tools, through: :transactions
  has_many :received_messages, inverse_of: :recipient, class_name: "Message", :foreign_key => 'recipient_id'
  has_many :sent_messages, inverse_of: :sender, class_name: "Message", :foreign_key => 'sender_id'

  attr_accessor :password, :password_confirmation, :avatar_cache

  before_save :set_random_password, :encrypt_password
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, confirmation: true
  mount_uploader :avatar, ProfileUploader

  def self.authenticate email, password
    user = User.find_by email: email
    user if user and user.authenticate(password)
  end

  def self.find_by_code code
    if user = User.find_by({:code => code, :expires_at => {"$gte" => Time.now.gmtime}})
      user.set_expiration
    end
    user
  end

  def authenticate password
    self.fish == BCrypt::Engine.hash_secret(password, self.salt)
  end


  def set_password_reset
    self.code = SecureRandom.urlsafe_base64
    set_expiration
  end

  def set_expiration
    self.expires_at = PASSWORD_RESET_EXPIRES.hours.from_now
    self.save
  end

  def reset_password(params)
    if params[:password].blank?
      self.errors.add(:password, "can't be blank")
      false
    else
      if self.update_attributes(params)
        self.update_attributes(params.merge( code: nil, expires_at: nil ))
      end
    end
  end

  def unread_messages?
    unread_messages_count > 0 ? true : false
  end

  def unread_message_count
    eval 'messages.count(:conditions => ["recipient_id = ? AND read_at IS NULL", self.user_id])'
  end

  protected

    def set_random_password
      if self.fish.blank? and password.blank?
        self.salt = BCrypt::Engine.generate_salt
        self.fish = BCrypt::Engine.hash_secret(SecureRandom.base64(32), self.salt)
      end
    end

    def encrypt_password
      if password.present?
        self.salt = BCrypt::Engine.generate_salt
        self.fish = BCrypt::Engine.hash_secret(password, self.salt)
      end
    end

end
