# following methods used for unit specs
def sets_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def clear_current_user
  session[:user_id] = nil
end

# following methods used for feature specs
def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit log_in_path
  within(".jumbotron") do
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("Log In")
  end
end