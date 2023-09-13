class AddScheduleIdToTodo < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :schedule_id, :integer
    add_foreign_key :todos, :schedules
  end
end
