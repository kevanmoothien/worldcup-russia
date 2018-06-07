class BetSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :score_a, :score_b, :match_id

  def match_id
    object.match.public_id
  end

  def id
    object.public_id
  end
end
