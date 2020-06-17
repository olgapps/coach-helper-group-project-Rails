class AlterColumnPlayBooksName < ActiveRecord::Migration[5.2]
  def change
    add_index :play_books, :name, unique: true
  end
end
