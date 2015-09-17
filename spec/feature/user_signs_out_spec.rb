require 'rails_helper'

feature 'user signs out', %Q{
  As a user
  I want to be able to sign out
  So that other users of my computer can't pretend to be me
} do
  # Acceptance Criteria
  #
  # - I must be able to sign out from any index page

  scenario 'sign out from main page' do
    user = User.create!(provider: "github", uid: '12345', name:'Joe')

    visit '/'

    sign_in_as(user)

    expect(page).to have_content("Signed in!")
    expect(page).to have_content("Welcome #{user.name}")

    click_on("Sign out")

    expect(page).to have_content("Questions Posted")
    expect(page).to have_content("Signed out!")
    expect(page).to have_content("Sign in with Github")
  end

  OmniAuth.config.mock_auth[:github] = nil

  scenario 'sign out from question page' do
    user = User.create!(provider: "github", uid: '12345', name:'Joe')
    question = Question.create!(title: ("a" * 51), description: ("a" * 151))

    visit '/'

    sign_in_as(user)

    expect(page).to have_content("Signed in!")
    expect(page).to have_content("Welcome #{user.name}")

    click_on(question.title)

    click_on("Sign out")

    expect(page).to have_content("Questions Posted")
    expect(page).to have_content("Signed out!")
    expect(page).to have_content("Sign in with Github")
  end

  OmniAuth.config.mock_auth[:github] = nil
end
