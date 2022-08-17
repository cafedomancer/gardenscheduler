class CreateVarieties < ActiveRecord::Migration[6.1]
  def change
    create_table :varieties do |t|
      t.text :name, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
