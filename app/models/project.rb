class Project < ApplicationRecord
  has_many :notes, as: :noteable, dependent: :destroy
  has_many :milestones, dependent: :destroy
  has_and_belongs_to_many :resources, uniq: false
  has_many :invoices
  has_many :log_hours
  belongs_to :client, optional: true

  enum project_type: [:fixed, :hourly], _default: :fixed
  enum project_status: [:completed, :in_progress], _default: :in_progress

  validates :project_status, :project_type, :start_date,
            :submission_date, presence: true

  scope :fixed_projects, ->{ where( project_type: :fixed ) }
end
