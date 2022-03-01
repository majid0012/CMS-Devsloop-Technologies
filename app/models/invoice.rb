class Invoice < ApplicationRecord
  belongs_to :project
  has_many :notes, as: :noteable, dependent: :destroy

  enum invoice_type: [:monthly, :bi_monthly, :hourly], _default: :monthly
  enum invoice_item: [:hour, :milestone], _default: :milestone
end
