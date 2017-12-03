class AddWalkdistanceToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :distance, :float
  end
end
