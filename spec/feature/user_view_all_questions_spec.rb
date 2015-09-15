require 'rails_helper'

feature 'visitor views questions', %Q{
  As a user
  I want to view recently posted questions
  So that I can help others
} do
  # Acceptance Criteria
  #
  # - I must see the title of each question
  # - I must see questions listed in order, most recently posted first

  scenario 'see the title of each question' do
    Question.create!(title: 'This title is long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating')
    Question.create!(title: 'This title is also long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating again')

    first_question = Question.all.first.title
    last_question = Question.all.last.title
    visit '/'

    expect(page).to have_content(first_question)
    expect(page).to have_content(last_question)
  end

  scenario 'see the most recent question listed first' do
    Question.create!(title: 'This title is long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating')
    Question.create!(title: 'This title is also long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating again')

    first_question = Question.all.first.title
    last_question = Question.all.last.title
    visit '/'

    # binding.pry
    expect(last_question).to be < first_question
  end
end
