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
            :foreign_key => :answer_choice_id,
            :primary_key => :id




  belongs_to  :poll,
              :class_name => 'Poll',
              :foreign_key => :poll_id,
              :primary_key => :id


end
