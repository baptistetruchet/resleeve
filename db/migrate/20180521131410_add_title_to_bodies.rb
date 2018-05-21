class AddTitleToBodies < ActiveRecord::Migration[5.2]
  def change
    add_column :bodies, :title, :string
  end
end
