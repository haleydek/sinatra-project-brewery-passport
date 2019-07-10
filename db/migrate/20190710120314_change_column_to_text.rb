class ChangeColumnToText < ActiveRecord::Migration[5.2]
  def change
    change_column :breweries, :description, :text
  end
end
