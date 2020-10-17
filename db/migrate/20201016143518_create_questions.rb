class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions, comment: 'Save questions' do |t|
      t.references :survey, null: false, foreign_key: true, index: true
      t.string :title, null: false
      t.string :question_type

      t.timestamps null: false
    end
  end
end
