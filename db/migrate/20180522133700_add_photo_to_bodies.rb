class AddPhotoToBodies < ActiveRecord::Migration[5.2]
  def change
    add_column :bodies, :photo, :string
  end
end
