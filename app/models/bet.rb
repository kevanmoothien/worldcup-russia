class Bet < ActiveRecord::Base
  belongs_to :match
  belongs_to :user

  def score
    if score_a == nil || score_b == nil || match.score_a == nil || match.score_b == nil
      return 0
    end
    #exact score prediction
    if score_a == match.score_a && score_b == match.score_b
      return 3
    end
    #exact win prediction
    if score_a > score_b && match.score_a > match.score_b
      return 1
    end
    if score_a < score_b && match.score_a < match.score_b
      return 1
    end
    if score_a == score_b && match.score_a == match.score_b
      return 1
    end
    return 0
  end
end
