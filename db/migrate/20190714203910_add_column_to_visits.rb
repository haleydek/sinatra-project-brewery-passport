class AddColumnToVisits < ActiveRecord::Migration[5.2]
  def change
    add_column :visits, :rating, :integer
  end
end
