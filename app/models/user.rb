class User < ApplicationRecord
  before_save { downcase_email }

  has_many :articles, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }

  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 }, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_secure_password

  private

  def downcase_email
    self.email = email.downcase
  end
end
