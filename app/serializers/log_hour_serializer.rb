class LogHourSerializer
  include JSONAPI::Serializer
  attributes :date, :time_spent, :work_description, :project_id
end
