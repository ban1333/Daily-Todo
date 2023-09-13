class AddTodoColumnToCompleteds < ActiveRecord::Migration[7.0]
  def change
    add_column :completeds, :todo_id, :integer
  end
end
