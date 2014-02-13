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
  validates :answer_choice_id, presence: true
  validate :has_not_already_answered_question
  validate :cannot_answer_own_question

  belongs_to  :answer_choice,
              :class_name => "AnswerChoice",
              :foreign_key => :answer_choice_id,
              :primary_key => :id

  belongs_to  :respondent,
              :class_name => "User",
              :foreign_key => :user_id,
              :primary_key => :id

  has_one  :question, :through => :answer_choice, :source => :question


  def has_not_already_answered_question
    existing = existing_responses
    unless existing.empty? || (self.id == existing.first.id && existing.count == 1)
      errors.add(:already_answered, "You can't answer the same question twice")
    end
  end

  def cannot_answer_own_question
    unless (User::find(self.user_id).author_polls.joins(:question_answers).where('answer_choices.id = ?', self.answer_choice_id)).empty?
      errors.add(:self_answer, "You cannot answer your own question")
    end
  end

  private

  def existing_responses
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
