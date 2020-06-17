class AddSuspendedToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :suspended, :boolean, default: false, null: false
  end
end
