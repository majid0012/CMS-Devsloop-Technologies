class LogHour < ApplicationRecord
    belongs_to :project, -> { where :project_type => :hourly }
    has_many :notes, as: :noteable, dependent: :destroy

    validates :date, :time_spent, :work_description, presence: true
end
