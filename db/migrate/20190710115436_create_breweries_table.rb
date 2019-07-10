class CreateBreweriesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :breweries do |t|
      t.string :name
      t.string :description
      t.string :url
      t.string :street_address
      t.string :city
      t.string :state
    end
  end
end
