class AddClosedMatchToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :closed_match, :boolean, default: false, null: false
  end
end
