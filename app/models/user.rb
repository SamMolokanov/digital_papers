class User < ApplicationRecord
  class SessionDuplicateError < StandardError
  end

  has_many :documents

  has_secure_password

  attribute :sessions, :user_sessions

  validates_confirmation_of :password
  validates :email,
    presence: true,
    uniqueness: true,
    case_sensitive: false,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates_length_of :name, :email, :password_digest, maximum: 255

  def self.find_by_token(token)
    users = where("users.sessions @> ?", [token: token].to_json)

    raise SessionDuplicateError if users.length > 1

    users.first
  end

  def email=(email_value)
    email_value.is_a?(String) ? super(email_value.downcase.strip) : super
  end
end
