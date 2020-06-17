class RemoveRedCardsFromPlayers < ActiveRecord::Migration[5.2]
  def change
    remove_column :players, :red_cards, :integer
  end
end
