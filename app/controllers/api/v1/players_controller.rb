class Api::V1::PlayersController < ApiController
  def index
    @players = Player.where(user_id: current_user.id)
  end
end
