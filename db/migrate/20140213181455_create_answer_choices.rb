class CreateAnswerChoices < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.belongs_to :question
      t.string :text, :length => 1024

      t.timestamps
    end
    add_index :answer_choices, :question_id
  end
end
