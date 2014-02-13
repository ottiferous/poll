class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.belongs_to :user
      t.belongs_to :answer_choice

      t.timestamps
    end
    add_index :responses, :user_id
    add_index :responses, :answer_choice_id
  end
end
