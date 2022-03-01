class Resource < ApplicationRecord
  has_and_belongs_to_many :projects, uniq: false
  has_many :notes, as: :noteable, dependent: :destroy

  validates :name, :designation, :salary, :phone_number, presence: true
  validates :email_address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'please enter valid email address' }
end
