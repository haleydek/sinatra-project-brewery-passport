class CreateBreweryTable < ActiveRecord::Migration[5.2]
  def change
    create_table :breweries do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone
    end
  end
end
