class Events::PlayersController < ApplicationController
  def assign
    @event = Event.find(params[:event_id])
    @player = Player.find(params[:id])
    if !@event.players.include?(@player)
      @event.players << @player
      redirect_to events_path, notice: 'Player was successfully added.'
    else
      redirect_to events_path, alert: 'Player has not been added!'
    end
  end

  def update
    @player = Player.find(params[:id])
    update_params = player_params
    if update_params[:yellow_cards] && update_params[:yellow_cards] == '1'
      update_params[:yellow_cards] = @player.yellow_cards
      update_params = Player.suspend(update_params)
    end
    @event = Event.find(params[:event_id])
    if @player.update(update_params)
      render 'events/update_modal'
    else
      render 'events/error'
    end
  end

  private

  def player_params
    params.require(:player).permit(:yellow_cards, :suspended, :injury)
  end

  def event_params
    params.require(:event).permit(:closed_match)
  end
end
