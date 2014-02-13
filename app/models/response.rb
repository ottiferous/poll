# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  answer_choice_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#


class Response < ActiveRecord::Base

  validates :user_id, presence: true
  before_save :has_not_already_answered_question
  validates :answer_choice_id, presence: true

  belongs_to  :answer_choice,
              :class_name => "AnswerChoice",
              :foreign_key => :answer_choice_id,
              :primary_key => :id

  belongs_to  :respondent,
              :class_name => "User",
              :foreign_key => :user_id,
              :primary_key => :id

  def has_not_already_answered_question
    existing = existing_responses
    p existing
    existing.empty? || (self.id == existing.first.id && existing.count == 1)
  end

  private

  def existing_responses
    # attributes_hash = { :answer_choice_id => self.answer_choice_id, :user_id => self.user_id }

    Response::find_by_sql [<<-SQL, self.user_id, self.answer_choice_id]
      SELECT  responses.*
      FROM    responses
                JOIN answer_choices
                  ON responses.answer_choice_id = answer_choices.id
      WHERE
      responses.user_id = ?
      AND
      answer_choices.question_id = (SELECT answer_choices.question_id
                                    FROM
                                    answer_choices
                                    WHERE
                                    answer_choices.id = ?)

    SQL
  end

end
