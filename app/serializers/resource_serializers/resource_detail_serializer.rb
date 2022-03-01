class ResourceSerializers::ResourceDetailSerializer
  include JSONAPI::Serializer
  has_many :notes, serializer: NoteSerializer

  attributes :name, :designation, :salary, :email_address, :phone_number
end
