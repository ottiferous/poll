# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#


class Poll < ActiveRecord::Base
  validates :title, presence: true
  validates :author_id, presence: true


  belongs_to  :author,
              :class_name => 'User',
              :foreign_key => :author_id,
              :primary_key => :id

  has_many  :questions,
            :class_name => 'Question',
            :foreign_key => :poll_id,
            :primary_key => :id,
            dependent: :destroy


  has_many  :question_answers,
            :through => :questions,
            :source => :answer_choices

  def results
    questions.includes(:my_responses).group('answer_choices.text').references(:my_responses).count("responses.*")
  end

end
