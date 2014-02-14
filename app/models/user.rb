# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#



class User < ActiveRecord::Base

  validates :user_name, presence: true, uniqueness: true

  has_many  :author_polls,
            :class_name => 'Poll',
            :foreign_key => :author_id,
            :primary_key => :id

  has_many  :responses,
            :class_name => 'Response',
            :foreign_key => :user_id,
            :primary_key => :id,
            dependent: :destroy


            has_many :question_answers, :through => :responses, :source => :answer_choice

  def uncompleted_polls
    polls = Poll::find_by_sql [ <<-SQL, self.id ]
      SELECT all_polls.poll_id AS id
      FROM   (SELECT polls.id           AS poll_id,
                     Count(questions.*) AS num_of_questions
              FROM   polls
                     JOIN questions
                       ON polls.id = questions.poll_id
              GROUP  BY polls.id) AS all_polls
             LEFT OUTER JOIN (SELECT polls.id AS poll_reply_id,
                                     Count(responses.*)
                              FROM   polls
                                     JOIN questions
                                       ON polls.id = questions.poll_id
                                     JOIN answer_choices
                                       ON questions.id = answer_choices.question_id
                                     JOIN responses
                                       ON answer_choices.id =
                                          responses.answer_choice_id
                                     JOIN users
                                       ON responses.user_id = users.id
                              WHERE  responses.user_id = ?
                              GROUP  BY polls.id) AS poll_reply
                          ON all_polls.poll_id = poll_reply.poll_reply_id
      WHERE  all_polls.num_of_questions != poll_reply.count
    SQL
        # add this line at the bottom of the above HEREDOC if you want to also return polls you haven't started
        # OR poll_reply IS NULL
    polls
  end

  def completed_polls
  polls = Poll::find_by_sql [ <<-SQL, self.id ]
    SELECT all_polls.poll_id AS id
    FROM   (SELECT polls.id           AS poll_id,
                   Count(questions.*) AS num_of_questions
            FROM   polls
                   JOIN questions
                     ON polls.id = questions.poll_id
            GROUP  BY polls.id) AS all_polls
           LEFT OUTER JOIN (SELECT polls.id AS poll_reply_id,
                                   Count(responses.*)
                            FROM   polls
                                   JOIN questions
                                     ON polls.id = questions.poll_id
                                   JOIN answer_choices
                                     ON questions.id = answer_choices.question_id
                                   JOIN responses
                                     ON answer_choices.id =
                                        responses.answer_choice_id
                                   JOIN users
                                     ON responses.user_id = users.id
                            WHERE  responses.user_id = ?
                            GROUP  BY polls.id) AS poll_reply
                        ON all_polls.poll_id = poll_reply.poll_reply_id
    WHERE  all_polls.num_of_questions = poll_reply.count
  SQL

  polls
  end
end
