module Api::V1
  class UsersController < ApiController
    before_action :authenticate_user!, except: :no_bet
    def index
      render json: User.where(active: true).page(params[:page]).per(10), each_serializer: UserSerializer
    end

    def me
      render json: current_user
    end

    def show
      render json: User.find_by(public_id: params[:id])
    end

    def no_bet
      if params['token'] != ENV['TOKEN']
        render json: []
        return
      end
      matches = Match.where(schedule: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).pluck(:id)
      if matches.size == 0
        render json: []
        return
      end
      users_found = User.joins(:bets).where('bets.match_id IN (?)',
                    matches)
      users = User.where.not(id: users_found.pluck(:id)).pluck(:email)
      render json: users
    end
  end
end

