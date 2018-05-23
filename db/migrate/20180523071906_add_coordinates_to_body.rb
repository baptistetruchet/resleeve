class AddCoordinatesToBody < ActiveRecord::Migration[5.2]
  def change
    add_column :bodies, :latitude, :float
    add_column :bodies, :longitude, :float
  end
end
