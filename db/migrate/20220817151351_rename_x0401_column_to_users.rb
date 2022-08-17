class RenameX0401ColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :x0401, :prefecture_id
  end
end
