class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :body, foreign_key: true
      t.date :date_in
      t.date :date_out
      t.string :status

      t.timestamps
    end
  end
end
