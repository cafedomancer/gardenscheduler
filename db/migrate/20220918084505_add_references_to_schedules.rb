class AddReferencesToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_reference :schedules, :schedule, foreign_key: true
  end
end
