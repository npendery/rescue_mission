require 'rails_helper'

feature 'visitor views questions details', %Q{
  As a user
  I want to view a question's details
  So that I can effectively understand the question
} do
  # Acceptance Criteria
  #
  # - I must be able to get to this page from the questions index
  # - I must see the question's title
  # - I must see the question's description

  scenario 'navagating from questions index' do
    Question.create!(title: 'This title is long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating')
    Question.create!(title: 'This title is also long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating again')

    first_question = Question.all.first
    last_question = Question.all.last
    visit '/'

    click_on(first_question.title)
    expect(page).to have_content(first_question.title)
    expect(page).to have_content(first_question.description)
    expect(current_path).to eq("/questions/#{first_question.id}")
  end
end
