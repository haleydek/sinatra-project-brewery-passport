class ChangeColumnsToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :visits, :user_id, :integer
    change_column :visits, :brewery_id, :integer
  end
end
