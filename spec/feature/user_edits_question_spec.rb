require 'rails_helper'

feature 'visitor edits a question', %Q{
  As a user
  I want to edit a question
  So that I can correct any mistakes or add updates
} do
  # Acceptance Criteria
  #
  # - I must provide valid information
  # - I must be presented with errors if I fill out the form incorrectly
  # - I must be able to get to the edit page from the question details page

  scenario 'Update question is done correctly' do
    question = Question.create!(title: 'This title is long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating')

    visit '/'

    click_link("This title is long enough for being a title")

    click_link("Edit Question")

    fill_in 'Title', with: 'b' * 51

    fill_in 'Description', with: "a" * 151

    click_on("Update Question")

    expect(page).to have_content("b" * 51)
    expect(page).to have_content("a" * 151)
    expect(page).to have_content("Question Updated")
  end

  scenario 'Update questions title is done incorrectly' do
    question = Question.create!(title: 'This title is long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating')

    visit '/'

    click_link("This title is long enough for being a title")

    click_link("Edit Question")

    fill_in 'Title', with: 'b' * 21

    fill_in 'Description', with: "a" * 151

    click_on("Update Question")

    expect(page).to have_content("Question not updated")
  end

  scenario 'Update questions description is done incorrectly' do
    question = Question.create!(title: 'This title is long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating')

    visit '/'

    click_link("This title is long enough for being a title")

    click_link("Edit Question")

    fill_in 'Title', with: 'b' * 51

    fill_in 'Description', with: "a" * 101

    click_on("Update Question")

    expect(page).to have_content("Question not updated")
  end
end
