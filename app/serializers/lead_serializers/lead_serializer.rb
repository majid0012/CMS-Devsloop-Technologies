class LeadSerializers::LeadSerializer
  include JSONAPI::Serializer
  attributes :title, :company_name, :company_address, :email_address, :phone_number
end
