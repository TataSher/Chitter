feature 'authentication' do
  it 'a user can sign in' do
    User.create(username: 'Test User', email: "test_user@mail.com", password: "password123")

    visit "/sessions/new"
    fill_in(:email, with: "test_user@mail.com")
    fill_in(:password, with: "password123")
    click_button('Sign In')

    expect(page).to have_content 'Welcome, Test User!'
  end
end