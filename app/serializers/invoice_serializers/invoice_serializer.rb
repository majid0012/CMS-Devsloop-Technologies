class InvoiceSerializers::InvoiceSerializer
  include JSONAPI::Serializer
  attributes :invoice_item, :total_amount, :invoice_type, :project_id
end
