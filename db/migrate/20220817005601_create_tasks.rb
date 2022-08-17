class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :schedule_id, null: false
      t.integer :user_id, null: false
      t.date :date
      t.text :name
      t.text :plan_memo
      t.text :done_memo
      t.datetime :done_at

      t.timestamps
    end
  end
end
