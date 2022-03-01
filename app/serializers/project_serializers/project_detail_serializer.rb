class ProjectSerializers::ProjectDetailSerializer
  include JSONAPI::Serializer
    has_many :notes, serializer: NoteSerializer
    has_many :log_hours, serializer: LogHourSerializer
    has_many :invoices, serializer: InvoiceSerializer

    attributes :project_type, :start_date, :submission_date, :project_status
end
