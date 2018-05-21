class CreateBodies < ActiveRecord::Migration[5.2]
  def change
    create_table :bodies do |t|
      t.references :user, foreign_key: true
      t.integer :price_per_day
      t.string :location
      t.string :sex
      t.text :description

      t.timestamps
    end
  end
end
