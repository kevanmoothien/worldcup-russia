class Match < ActiveRecord::Base
  belongs_to :team_a, class_name: 'Team', foreign_key: 'team_a'
  belongs_to :team_b, class_name: 'Team', foreign_key: 'team_b'

  has_many :bets
end
