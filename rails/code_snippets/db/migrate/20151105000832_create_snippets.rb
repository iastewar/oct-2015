class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :kind
      t.string :title
      t.text :work

      t.timestamps null: false
    end
  end

  add_index :snippets, :kind
end
