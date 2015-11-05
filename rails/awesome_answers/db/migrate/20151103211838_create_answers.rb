class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      # tells rails to generate an integer field called question_id (by convention).
      # foreign_key: true makes sure that question_id is in the questions table.
      # index: true speeds up accessing all answers with a specific question_id by adding
      # an index on the question_id field.
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
