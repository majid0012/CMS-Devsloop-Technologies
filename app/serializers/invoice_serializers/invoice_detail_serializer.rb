class InvoiceSerializers::InvoiceDetailSerializer
  include JSONAPI::Serializer
  has_many :notes, serializer: NoteSerializer
  
  attributes :invoice_item, :total_amount, :invoice_type, :project_id
end
