feature 'registering a user' do
  scenario 'a user can sign up' do
    visit '/users/new'
    fill_in('username', with: "User_1")
    fill_in('email', with: "user_1@email.com")
    fill_in('password', with: "password123")
    click_button("Sign Up")

    expect(page).to have_content("Welcome, User_1")
  end
end