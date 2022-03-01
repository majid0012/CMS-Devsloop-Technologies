class MilestoneSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :budget, :project_id
end
