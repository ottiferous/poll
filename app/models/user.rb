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
            :primary_key => :id


            has_many :question_answers, :through => :responses, :source => :answer_choice

  def completed_polls
    #returns poll objects / ids of polls where a user has answered all of the questions in the poll.
    # Responses -> AnswerChoice -> Question -> Poll -> Questions
    # questions.includes(:my_responses).group('answer_choices.text').references(:my_responses).count("responses.*")

    self.responses
  end
end
