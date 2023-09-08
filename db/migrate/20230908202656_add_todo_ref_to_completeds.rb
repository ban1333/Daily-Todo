class AddTodoRefToCompleteds < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :completeds, :todos
  end
end
