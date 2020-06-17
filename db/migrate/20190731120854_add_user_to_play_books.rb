class AddUserToPlayBooks < ActiveRecord::Migration[5.2]
  def change
    add_reference :play_books, :user, foreign_key: true  
  end
end
