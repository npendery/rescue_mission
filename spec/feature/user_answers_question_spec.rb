require 'rails_helper'

feature 'visitor posts a question', %Q{
  As a user
  I want to answer another user's question
  So that I can help them solve their problem
} do
  # Acceptance Criteria
  #
  # - I must be on the question detail page
  # - I must provide a description that is at least 50 characters long
  # - I must be presented with errors if I fill out the form incorrectly

  scenario 'answer question is done correctly' do
    question = Question.create!(title: 'This title is long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating')

    visit '/'

    click_link("This title is long enough for being a title")

    click_link("New answer")

    fill_in 'Description', with: "a" * 51

    click_on("Create Answer")
    expect(page).to have_content("a" * 51)
    expect(page).to have_content("Answer Saved")
  end

  scenario 'answer question is done wrong' do
    question = Question.create!(title: 'This title is long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating')

    visit '/'

    click_link("This title is long enough for being a title")

    click_link("New answer")

    fill_in 'Description', with: "a" * 30

    click_on("Create Answer")
    expect(page).to have_content("Answer not saved")
  end
end
