class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.user.name.name_max_length}

  validates :email, presence: true,
            length: {in: Settings.user.email.email_range_length},
            format: {with: Settings.user.email_regex},
            uniqueness: true

  validates :password, presence: true,
            length: {minimum: Settings.user.password.password_min_length},
            if: :password

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
