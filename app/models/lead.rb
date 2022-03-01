class Lead < ApplicationRecord
  has_many :notes, as: :noteable, dependent: :destroy

  validates_associated :notes
  validates :title, :company_name, :company_address, presence: true
  validates :email_address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'please enter valid email address' }
end
