class AddProjectToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :project, :text
  end
end
