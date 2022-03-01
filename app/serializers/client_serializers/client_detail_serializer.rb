class ClientSerializers::ClientDetailSerializer
  include JSONAPI::Serializer
  has_many :projects, serializer: ProjectSerializers::ProjectSerializer
  has_many :notes, serializer: NoteSerializer

  attributes :name, :email_address
end