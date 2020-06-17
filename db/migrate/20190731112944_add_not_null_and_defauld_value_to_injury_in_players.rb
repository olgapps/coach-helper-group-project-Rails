class AddNotNullAndDefauldValueToInjuryInPlayers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :players, :injury, false
    change_column_default :players, :injury, ""
  end
end
