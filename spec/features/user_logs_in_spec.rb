require 'rails_helper'

feature "User logs in" do
  scenario "user successfully logs in", js: true do
    Fabricate(:user, email: "test@example.com", password: "password")
    visit root_path
    click_button("Log in")
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    click_button "Log In"
    expect(page).to have_content "test@example.com"
  end
end