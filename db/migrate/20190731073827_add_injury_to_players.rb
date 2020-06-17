class AddInjuryToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :injury, :text
  end
end
