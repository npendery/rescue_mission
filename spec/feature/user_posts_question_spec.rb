require 'rails_helper'

feature 'visitor posts a question', %Q{
  As a user
  I want to post a question
  So that I can receive help from others
} do
  # Acceptance Criteria
  #
  # - I must provide a title that is at least 40 characters long
  # - I must provide a description that is at least 150 characters long
  # - I must be presented with errors if I fill out the form incorrectly

  scenario 'post question successfully' do
    user = User.create!(provider: "github", uid: '12345', name:'Joe')
    visit '/'
    sign_in_as(user)

    click_link("New Question")

    fill_in 'Title', with: "b" * 40
    fill_in 'Description', with: "a" * 151

    click_on("Create Question")
    expect(page).to have_content("b" * 40)
    expect(page).to have_content("a" * 151)
    expect(page).to have_content("Question Saved")
  end

  scenario 'post question with not enough title text' do
    visit '/'

    click_link("New Question")

    fill_in 'Title', with: "b" * 20
    fill_in 'Description', with: "a" * 151

    click_on("Create Question")
    expect(page).to have_content("40 characters is the minimum allowed for the title")
    expect(page).to_not have_content("Title can't be blank")
    expect(page).to have_content("Question not saved")
    expect(current_path).to eq("/questions")
  end

  scenario 'post question with not enough description text' do
    user = User.create!(provider: "github", uid: '12345', name:'Joe')
    visit '/'
    sign_in_as(user)

    click_link("New Question")

    fill_in 'Title', with: "b" * 40
    fill_in 'Description', with: "a" * 20

    click_on("Create Question")
    expect(page).to have_content("150 characters is the minimum allowed for the description")
    expect(page).to_not have_content("Description can't be blank")
    expect(page).to have_content("Question not saved")
    expect(current_path).to eq("/questions")
  end
end
