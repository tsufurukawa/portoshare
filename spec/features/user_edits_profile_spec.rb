require 'rails_helper'

feature "User edits profile" do
  given(:alice) { Fabricate(:user) }

  background do
    sign_in(alice)
    visit edit_user_path(alice)
  end

  scenario "user uploads new avatar" do
    attach_file "Upload your photo", "public/tmp/default_avatar_170.png"
    click_button "Update Profile"
    expect_new_image_in_user_profile(alice)
  end

  scenario "user updates account information" do
    update_user_account_information
    visit user_path(alice.reload)
    expect(page).to have_content "newemail@example.com"
    expect(page).to have_content "New Username"
  end

  scenario "user links Github account" do
    link_github_account
    expect(page).to have_content "You have successfully linked your Github account!"
    expect(page).to have_link "Unlink Your Github Account"
  end

  def expect_new_image_in_user_profile(user)
    visit user_path(user)
    expect(page).to have_css("img[alt='Default avatar 170']")
  end

  def update_user_account_information
    fill_in "Username", with: "New Username"
    fill_in "Email", with: "newemail@example.com"
    click_button "Update Profile"
  end

  def link_github_account
    visit "/auth/github"
  end
end