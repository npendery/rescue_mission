require 'rails_helper'

feature 'question best answer edit authorization', %Q{
  As a user
  I want to prevent other users from editing my questions best answer
  So that malicious users can't mess with my question
} do
  # Acceptance Criteria
  #
  # - I must be signed in
  # - I must be able to choose the "best" answer for a question that I posted
  # - I can't choose the best answer for a question that was posted by another user

  scenario 'user can edit their own questions best_answer' do
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

    click_on("Sign out")

    sign_in_as(user_2)

    expect(page).to have_content("Signed in!")
    expect(page).to have_content("Welcome #{user_2.name}")

    click_on(question_title)

    click_on("a" * 51)

    expect(page).to_not have_content("Edit Answer")
  end

  OmniAuth.config.mock_auth[:github] = nil
end
