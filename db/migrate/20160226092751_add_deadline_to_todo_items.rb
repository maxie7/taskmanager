class AddDeadlineToTodoItems < ActiveRecord::Migration
  def change
    add_column :todo_items, :deadline, :date
  end
end
