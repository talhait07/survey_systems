class CreateQuestionChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :question_choices, comment: 'Save question choices' do |t|
      t.references :question, index: true, foreign_key: true, null: false
      t.string :title, null: false
      t.integer :next_question_id

      t.timestamps null: false
    end
  end
end
