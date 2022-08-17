class AddX0401ToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :x0401, :integer
    add_column :users, :notification_time, :datetime
  end
end
