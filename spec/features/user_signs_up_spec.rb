require 'rails_helper'

feature "User signs up" do
  scenario "user successfully signs up for an account", js: true do
    sample_user = Fabricate(:user, username: "tsufurukawa")
    Fabricate(:project, title: "PortoShare", user: sample_user)
    visit root_path
    click_button("Sign up")
    fill_in "Name", with: "Test User"
    fill_in "Username", with: "testuser"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    click_button("Sign Up")
    expect(page).to have_content "Welcome to PortoShare!!"
    expect(page).to have_content "test@example.com"
  end
end