# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  poll_id    :integer
#  text       :text
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  has_many  :answer_choices,
            :class_name => 'AnswerChoice',
            :foreign_key => :question_id,
            :primary_key => :id


  belongs_to  :poll,
              :class_name => 'Poll',
              :foreign_key => :poll_id,
              :primary_key => :id


  has_many :my_responses, :through => :answer_choices, :source => :responses


  def results
    self.my_responses.group(:answer_choices).count(:responses)

  end

end
