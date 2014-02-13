# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = User.new(:user_name => "kevin")
user2 = User.new(:user_name => "andrew")
user3 = User.new(:user_name => "max")


poll = Poll.new(:title => "A great new poll!", :author => user.id)
poll2 = Poll.new(:title => "An even better poll thant that other one!", :author => user2.id)

question = Question.new(:poll_id => poll.id, :text => "When do you wake up in the morning?")
question2 = Question.new(:poll_id => poll.id, :text => "How do you take your coffee?")
question3 = Question.new(:poll_id => poll2.id, :text => "How do you get to work?")
question4 = Question.new(:poll_id => poll2.id, :text => "Are you ever going to let me down?")
question5 = Question.new(:poll_id => poll2.id, :text => "Are you ever going to hurt me?")

choice = AnswerChoice.new(:question_id => question.id, :text => "6 A.M")
choice1 = AnswerChoice.new(:question_id => question.id, :text => "7 A.M")
choice2 = AnswerChoice.new(:question_id => question.id, :text => "8 A.M")

choice3 = AnswerChoice.new(:question_id => question2.id, :text => "Black")
choice4 = AnswerChoice.new(:question_id => question2.id, :text => "with cream")
choice5 = AnswerChoice.new(:question_id => question2.id, :text => "with cream and sugar")

choice6 = AnswerChoice.new(:question_id => question3.id, :text => "I walk")
choice7 = AnswerChoice.new(:question_id => question3.id, :text => "I take the bus")
choice8 = AnswerChoice.new(:question_id => question3.id, :text => "I endure the bart")

reply = Response.new(:user_id => user.id, :answer_choice_id => choice1)
reply = Response.new(:user_id => user.id, :answer_choice_id => choice3)

reply = Response.new(:user_id => user2.id, :answer_choice_id => choice1)
reply = Response.new(:user_id => user2.id, :answer_choice_id => choice5)

reply = Response.new(:user_id => user3.id, :answer_choice_id => choice)
reply = Response.new(:user_id => user3.id, :answer_choice_id => choice4)