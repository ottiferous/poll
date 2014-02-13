# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  author     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Poll < ActiveRecord::Base

  belongs_to  :author,
              :class_name => 'User',
              :foreign_key => :author,
              :primary_key => :id

  has_many  :questions,
            :class_name => 'Question',
            :foreign_key => :question_id,
            :primary_key => :id

end
