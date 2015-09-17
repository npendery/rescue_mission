require 'rails_helper'

feature 'question edit & deletion authorization', %Q{
  As a user
  I want to prevent other users from editing my questions
  AND
  I want to prevent other users from deleting my question
  So that malicious users can't mess with my question
} do
  # Acceptance Criteria
  #
  # - I must be signed in
  # - I must be able to edit a question that I posted
  # - I can't edit a question that was posted by another user

  scenario 'user can edit & delete their own question' do
    user = User.create!(provider: "github", uid: '12345', name:'Joe')

    visit '/'

    sign_in_as(user)

    expect(page).to have_content("Signed in!")
    expect(page).to have_content("Welcome #{user.name}")

    click_link("New Question")

    fill_in 'Title', with: ("b" * 50)
    fill_in 'Description', with: ("a" * 151)

    click_on("Create Question")
    expect(page).to have_content("b" * 50)
    expect(page).to have_content("a" * 151)
    expect(page).to have_content("Question Saved")

    click_link("Edit Question")

    fill_in 'Title', with: ('b' * 55)

    click_on("Update Question")

    expect(page).to have_content("b" * 55)
    expect(page).to have_content("a" * 151)
    expect(page).to have_content("Question Updated")

    click_link("Delete Question")

    expect(page).to_not have_content("b" * 51)
    expect(page).to_not have_content("a" * 151)
    expect(page).to have_content("Question Deleted")
  end

  OmniAuth.config.mock_auth[:github] = nil

  scenario 'user cant edit anothers question' do
    user_1 = User.create!(provider: "github", uid: '12345', name:'Joe')
    user_2 = User.create!(provider: "github", uid: '12346', name:'Bill')
    question_title = ("b" * 50)
    question_desc = ("a" * 151)

    visit '/'

    sign_in_as(user_1)

    expect(page).to have_content("Signed in!")
    expect(page).to have_content("Welcome #{user_1.name}")

    click_link("New Question")

    fill_in 'Title', with: question_title
    fill_in 'Description', with: question_desc

    click_on("Create Question")
    expect(page).to have_content(question_title)
    expect(page).to have_content(question_desc)
    expect(page).to have_content("Question Saved")

    click_on("Sign out")

    sign_in_as(user_2)

    expect(page).to have_content("Signed in!")
    expect(page).to have_content("Welcome #{user_2.name}")

    click_on(question_title)

    expect(page).to_not have_content("Edit Question")
    expect(page).to_not have_content("Delete Question")
  end

  OmniAuth.config.mock_auth[:github] = nil
end
