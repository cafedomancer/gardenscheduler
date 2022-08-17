class RenameX0401ColumnToSchedules < ActiveRecord::Migration[6.1]
  def change
    rename_column :schedules, :x0401, :prefecture_id
  end
end
