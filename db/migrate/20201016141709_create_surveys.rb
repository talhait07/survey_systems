class CreateSurveys < ActiveRecord::Migration[6.0]
  def change
    create_table :surveys, comment: 'Save survey' do |t|
      t.string :title, null: false

      t.timestamps null: false
    end
  end
end
