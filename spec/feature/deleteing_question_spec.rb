require 'rails_helper'

feature 'visitor deletes a question', %Q{
  As a user
  I want to delete a question
  So that I can delete duplicate questions
} do
  # Acceptance Criteria
  #
  # - I must be able delete a question from the question edit page
  # - I must be able delete a question from the question details page
  # - All answers associated with the question must also be deleted

  scenario 'Delete question is done correctly from edit page' do
    question = Question.create!(title: ('b' * 51), description: ('a' * 151))

    visit '/'

    click_link('b' * 51)

    click_link("Edit Question")

    click_link("Delete Question")

    expect(page).to_not have_content("b" * 51)
    expect(page).to_not have_content("a" * 151)
    expect(page).to have_content("Question Deleted")
  end

  scenario 'Delete question is done correctly from details page' do
    question = Question.create!(title: ('b' * 51), description: ('a' * 151))

    visit '/'

    click_link('b' * 51)

    click_link("Delete Question")

    expect(page).to_not have_content("b" * 51)
    expect(page).to_not have_content("a" * 151)
    expect(page).to have_content("Question Deleted")
  end
end
