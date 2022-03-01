class Milestone < ApplicationRecord
    belongs_to :project, -> { where project_type: :fixed }

    validates :title, :description, :budget, presence: true
end
