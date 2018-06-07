class MatchSerializer < ActiveModel::Serializer
  attribute :public_id, key: :id
  attributes :created_at, :team_a, :team_b, :score_a, :score_b, :schedule, :user_score_a, :user_score_b

  def user_score_a
    bet = Bet.find_by(user_id: options[:user_id], match_id: object.id)
    return nil if bet.nil?
    bet.score_a
  end
  def user_score_b
    bet = Bet.find_by(user_id: options[:user_id], match_id: object.id)
    return nil if bet.nil?
    bet.score_b
  end
end
