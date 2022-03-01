class ClientSerializers::ClientSerializer
  include JSONAPI::Serializer
  attributes :name, :email_address
end
