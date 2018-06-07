class TeamSerializer < ActiveModel::Serializer
  attribute :public_id, key: :id
  attributes :created_at, :name, :image, :api_name, :matches, :flag

end
