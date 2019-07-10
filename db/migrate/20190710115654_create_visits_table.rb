class CreateVisitsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.string :user_id
      t.string :brewery_id
    end
  end
end
