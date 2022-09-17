class ChangeNotificationTimeToTime < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :notification_time, :time
  end
end
