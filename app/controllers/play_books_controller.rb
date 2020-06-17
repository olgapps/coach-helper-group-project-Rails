class PlayBooksController < ApplicationController
  def new; end

  def create
    @play_book = PlayBook.new(name: play_book_params[:name], user_id: current_user.id)
    respond_to do |format|
      if @play_book.save
        require 'base64'
        data = play_book_params[:data_uri]
        id = @play_book.id
        image_data = Base64.decode64(data['data:image/png;base64,'.length..-1])
        File.open(Rails.root.join('public', 'uploads', "#{id}.png"), 'wb') do |f|
          f.write image_data
        end
        format.html { redirect_to @play_book, notice: 'PlayBook was successfully created.' }
        format.json { render :show, status: :created, location: @play_book }
      else
        format.html { render :new }
        format.json { render json: @play_book.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @play_book = PlayBook.find(params[:id])
  end

  private

  def play_book_params
    params.require(:play_book).permit(:name, :data_uri)
  end
end
