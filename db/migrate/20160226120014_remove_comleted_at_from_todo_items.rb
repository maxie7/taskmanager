class RemoveComletedAtFromTodoItems < ActiveRecord::Migration
  def change
    remove_column :todo_items, :comleted_at, :datetime
  end
end
