module Api::V1
  class TeamsController < ApiController
    before_action :authenticate_user!
    def index
      render json: Team.all.page(params[:page]).per(10), each_serializer: TeamSerializer
    end
  end
end

