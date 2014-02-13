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

  has_many  :author_polls,
            :class_name => 'Poll',
            :foreign_key => :author,
            :primary_key => :id

  has_many  :responses,
            :class_name => 'Response',
            :foreign_key => :user_id,
            :primary_key => :id


end
