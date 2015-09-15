require 'rails_helper'

feature 'visitor posts a question', %Q{
  As a user
  I want to view the answers for a question
  So that I can learn from the answer
} do
  # Acceptance Criteria
  #
  # - I must be on the question detail page
  # - I must only see answers to the question I'm viewing
  # - I must see all answers listed in order, most recent last

  scenario 'answer question is seen' do
    question = Question.create!(title: 'This title is long enough for being a title', description: 'This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating, This is over 150 characters long because I am repeating')

    visit '/'

    click_link("This title is long enough for being a title")

    click_link("New answer")

    fill_in 'Description', with: "a" * 51

    click_on("Create Answer")

    click_link("New answer")

    fill_in 'Description', with: "b" * 51

    click_on("Create Answer")
    # save_and_open_page

    visit '/questions/' + question.id.to_s
    expect(page).to have_content("a" * 51)
    expect(page.body.index("b" * 51)).to be < page.body.index("a" * 51)
  end
end
