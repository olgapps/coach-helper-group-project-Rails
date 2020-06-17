class CreateJoinTableEventPlayBook < ActiveRecord::Migration[5.2]
  def change
    create_join_table :events, :play_books do |t|
       t.index [:event_id, :play_book_id]
    end
  end
end
