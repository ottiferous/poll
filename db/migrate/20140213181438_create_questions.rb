class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :poll
      t.text :text

      t.timestamps
    end

    add_index :questions, :poll_id
  end
end
