module Api::V1
  class BetsController < ApiController
    before_action :authenticate_user!
    def index
      render json: Bet.where(user_id: current_user.id)
    end

    def create
      match = Match.find_by public_id: params[:match_id]
      return if match.schedule < Time.zone.now
      bet = Bet.find_or_initialize_by(user_id: current_user.id, match_id: match.id)
      bet.score_a = params[:score_a]
      bet.score_b = params[:score_b]
      bet.save
      render json: bet
    end

    def update
      return if match.schedule < Time.zone.now
      bet = Bet.find_by(public_id: params[:id])
      bet.score_a = params[:score_a]
      bet.score_b = params[:score_b]
      bet.save
      render json: bet
    end

    def show
      bet = Bet.find_by(public_id: params[:id])
      render json: bet
    end

    def bulk_update
      return if params[:infos].nil?
      params[:infos].each do |item|
        temp = item
        match = Match.find_by(public_id: temp[:match_id])
        next if Time.zone.now > match.schedule
        bet = Bet.find_or_initialize_by user_id: current_user.id, match_id: match.id
        bet.score_a = temp[:score_a]
        bet.score_b = temp[:score_b]
        bet.save
      end
      render json: true
    end
  end
end

