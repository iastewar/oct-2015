class AddProjectToTask < ActiveRecord::Migration
  def change
    add_reference :tasks, :project
  end
end
