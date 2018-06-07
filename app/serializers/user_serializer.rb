class UserSerializer < ActiveModel::Serializer
  attribute :public_id, key: :id
  attributes :created_at, :email, :username, :admin, :score

  def score
    bets = Bet.all.where user_id: object.id
    score = 0
    bets.each do |bet|
      score = score + bet.score
    end
    score
  end

end
