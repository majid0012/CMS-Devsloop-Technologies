class ResourceSerializers::ResourceSerializer
  include JSONAPI::Serializer
  attributes :name, :designation, :salary, :email_address, :phone_number
end
