module Api::V1
  class MatchesController < ApiController
    before_action :authenticate_user!
    def index
      user = User.find_by public_id: params[:user_id]
      render json: Match.all.page(params[:page]).per(10), each_serializer: MatchSerializer, user_id: user.id
    end

    def create
      return unless current_user.admin?
      params[:infos].each do |item|
        match = item #JSON.parse(item)
        Match.create! team_a: Team.find_by(public_id: match[:teamA]), team_b: Team.find_by(public_id: match[:teamB]), schedule: match[:time], final: match[:final]
      end
      render json: {}
    end

    def destroy
      return unless current_user.admin?
      match = Match.find_by public_id: params[:id]
      match.destroy
      render json: match
    end

    def update
      return unless current_user.admin?
      match = Match.find_by public_id: params[:id]
      match.update! score_a: params[:score_a], score_b: params[:score_b]
      render json: {}
    end
  end
end

