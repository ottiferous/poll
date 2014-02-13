# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = User.create!(:user_name => "kevin")
user2 = User.create!(:user_name => "andrew")
user3 = User.create!(:user_name => "max")


poll = Poll.create!(:title => "A great new! poll!", :author_id => user.id)
poll2 = Poll.create!(:title => "An even better poll thant that other one!", :author_id => user2.id)

question = Question.create!(:poll_id => poll.id, :text => "When do you wake up in the morning?")
question2 = Question.create!(:poll_id => poll.id, :text => "How do you take your coffee?")
question3 = Question.create!(:poll_id => poll2.id, :text => "How do you get to work?")
question4 = Question.create!(:poll_id => poll2.id, :text => "Are you ever going to let me down?")
question5 = Question.create!(:poll_id => poll2.id, :text => "Are you ever going to hurt me?")

choice = AnswerChoice.create!(:question_id => question.id, :text => "6 A.M")
choice1 = AnswerChoice.create!(:question_id => question.id, :text => "7 A.M")
choice2 = AnswerChoice.create!(:question_id => question.id, :text => "8 A.M")

choice3 = AnswerChoice.create!(:question_id => question2.id, :text => "Black")
choice4 = AnswerChoice.create!(:question_id => question2.id, :text => "with cream")
choice5 = AnswerChoice.create!(:question_id => question2.id, :text => "with cream and sugar")

choice6 = AnswerChoice.create!(:question_id => question3.id, :text => "I walk")
choice7 = AnswerChoice.create!(:question_id => question3.id, :text => "I take the bus")
choice8 = AnswerChoice.create!(:question_id => question3.id, :text => "I endure the bart")

reply = Response.create!(:user_id => user.id, :answer_choice_id => choice1.id)
reply2 = Response.create!(:user_id => user.id, :answer_choice_id => choice3.id)

reply3 = Response.create!(:user_id => user2.id, :answer_choice_id => choice1.id)
reply4 = Response.create!(:user_id => user2.id, :answer_choice_id => choice5.id)

reply5 = Response.create!(:user_id => user3.id, :answer_choice_id => choice.id)
reply6 = Response.create!(:user_id => user3.id, :answer_choice_id => choice4.id)