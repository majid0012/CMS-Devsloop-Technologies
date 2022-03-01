class LeadSerializers::LeadDetailSerializer
  include JSONAPI::Serializer
  has_many :notes, serializer: NoteSerializer

  attributes :title, :company_name, :company_address, :email_address, :phone_number
end