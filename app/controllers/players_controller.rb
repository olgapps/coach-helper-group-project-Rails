class PlayersController < ApplicationController
  before_action :authenticate_user!

  def index
    @players = current_user.players
  end

  def new
    @player = Player.new
  end

  def create
    @player = current_user.players.build(player_params)
    if @player.save
      redirect_to players_path
    else
      render 'new'
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to players_url, notice: 'Post was successfully destroyed.'
  end

  def update
    @player = Player.find(params[:id])
    update_params = player_params
    if update_params[:yellow_cards] && update_params[:yellow_cards] == '1'
      update_params[:yellow_cards] = @player.yellow_cards
      update_params = Player.suspend(update_params)
    end

    if @player.update(update_params)
      redirect_to players_path, notice: 'Player was successfully updated.'
    else
      redirect_to players_path, alert: 'Player has not been updated!'
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :surname, :number, :birth_date, :trained_in, :yellow_cards, :suspended, :injury)
  end
end
