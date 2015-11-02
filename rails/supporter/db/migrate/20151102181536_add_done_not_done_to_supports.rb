class AddDoneNotDoneToSupports < ActiveRecord::Migration
  def change
    add_column :supports, :done, :boolean
  end
end
