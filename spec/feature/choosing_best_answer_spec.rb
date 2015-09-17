require 'rails_helper'

feature 'visitor choses a question', %Q{
  As a user
  I want to mark an answer as the best answer
  So that others can quickly find the answer
} do
  # Acceptance Criteria
  #
  # - I must be on the question detail page
  # - I must be able mark an answer as the best
  # - I must see the "best" answer above all other answers in the answer list

  scenario 'Mark answer as best from questions page and it move to the top of the list' do
    user = User.create!(provider: "github", uid: '12345', name:'Joe')
    question = Question.create!(title: 'This title is long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating', user_id: user.id)
    visit '/'
    sign_in_as(user)

    visit '/'

    click_link("This title is long enough for being a title")

    click_link("New answer")

    fill_in 'Description', with: "a" * 51

    click_on("Create Answer")

    click_link("New answer")

    fill_in 'Description', with: "b" * 51

    click_on("Create Answer")

    click_on("a" * 51)

    click_on("Edit Answer")

    page.check("answer[best_answer]")

    click_on("Update Answer")

    expect("a" * 51).to be < ("b" * 51)
    expect(page).to have_content("Answer Updated")
  end

  scenario 'answer question is done wrong' do
    user = User.create!(provider: "github", uid: '12345', name:'Joe')
    question = Question.create!(title: 'This title is long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating', user_id: user.id)
    visit '/'
    sign_in_as(user)
    
    click_link("This title is long enough for being a title")

    click_link("New answer")

    fill_in 'Description', with: "a" * 30

    click_on("Create Answer")
    expect(page).to have_content("Answer not saved")
  end
end
