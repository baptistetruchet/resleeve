class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :conversation, foreign_key: true
      t.references :sender
      t.references :receiver
      t.text :content

      t.timestamps
    end
  end
end
