class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = current_user.events.order(:event_date)
    @event = Event.new
    @play_books = current_user.play_books.all
    @players =  current_user.players.all
  end

  def import
    if params[:file]
      Event.importcsv(params[:file], current_user.id)
      redirect_to events_path, notice: 'Event was successfully updated.'
    else
      redirect_to events_path, notice: 'File was not specified'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to events_path
    else
      render 'new'
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  def close
    event = Event.find(params[:id])
    Player.remove_players_suspension_after_match(event.players, current_user.id)
    if event.update(closed_match: true)
      redirect_to events_path, notice: 'Event has been successfully closed.'
    else
      redirect_to events_path, alert: 'Event has not been closed!'
    end
  end

  private

  def event_params
    params.require(:event).permit(:opponent, :event_date)
  end
end
