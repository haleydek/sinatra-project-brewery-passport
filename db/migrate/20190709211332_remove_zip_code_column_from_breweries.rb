class RemoveZipCodeColumnFromBreweries < ActiveRecord::Migration[5.2]
  def change
    remove_column :breweries, :zip_code
  end
end
