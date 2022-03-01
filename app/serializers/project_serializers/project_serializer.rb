class ProjectSerializers::ProjectSerializer
  include JSONAPI::Serializer
  attributes :project_type, :start_date, :submission_date, :project_status
end