class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers, comment: 'Save answer of the questions' do |t|
      t.references :question, null: false, foreign_key: true, index: true
      t.string :response, null: false

      t.timestamps null: false
    end
  end
end
