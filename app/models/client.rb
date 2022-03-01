class Client < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :notes, as: :noteable, dependent: :destroy

  validates :name, presence: true
  validates :email_address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'please enter valid email address' }
end
