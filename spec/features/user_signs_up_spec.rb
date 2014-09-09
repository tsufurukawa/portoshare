require 'rails_helper'

feature "User signs up" do
  scenario "user successfully signs up for an account", js: true do
    visit root_path
    click_button("Sign up")
    fill_in "Name", with: "Test User"
    fill_in "Username", with: "testuser"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    click_button("Sign Up")
    expect(page).to have_content "You have successfully registered for an account. Welcome to Portoshare!!!"
    expect(page).to have_content "test@example.com"
  end
end