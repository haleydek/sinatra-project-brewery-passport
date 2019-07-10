class AddColumnToBreweries < ActiveRecord::Migration[5.2]
  def change
    add_column :breweries, :phone, :string
  end
end
