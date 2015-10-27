class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title #VARCHAR column in DB
      t.text :body  #TEXT column in DB

      t.timestamps null: false  # two timestamp columns: "created_at" and "updated_at"
    end
  end
end
