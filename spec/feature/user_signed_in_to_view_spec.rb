require 'rails_helper'

feature 'user authentication', %Q{
  As a user
  I want to sign in
  So that my questions and answers can be associated to me
} do
  # Acceptance Criteria
  #
  # - I must be able to sign in using either GitHub, Twitter, or Facebook (choose one)

  scenario 'sign in at the beginning page' do
    user = User.create!(provider: "github", uid: '12345', name:'Joe')

    visit '/'

    sign_in_as(user)

    expect(page).to have_content("Signed in!")
    expect(page).to have_content("Welcome #{user.name}")
  end

  OmniAuth.config.mock_auth[:github] = nil
end
