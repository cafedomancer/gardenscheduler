class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.text :name
      t.integer :x0401
      t.integer :user_id, null: false
      t.integer :variety_id, null: false

      t.timestamps
    end
  end
end
