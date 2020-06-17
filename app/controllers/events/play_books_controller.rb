class Events::PlayBooksController < ApplicationController
  def update
    @event = Event.find(params[:event_id])
    @play_book = PlayBook.find(params[:id])
    if !@event.play_books.include?(@play_book)
      @event.play_books << @play_book
      redirect_to events_path, notice: 'Play book was successfully added.'
    else
      redirect_to events_path, alert: 'Play book  has not been added!'
    end
  end
end
