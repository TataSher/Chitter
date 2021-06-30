feature 'authentication' do
  scenario 'a user can sign in' do
    User.create(username: 'Test User', email: "test_user@mail.com", password: "password123")

    visit "/sessions/new"
    fill_in(:email, with: "test_user@mail.com")
    fill_in(:password, with: "password123")
    click_button('Sign In')

    expect(page).to have_content 'Welcome, Test User!'
  end
  scenario 'a user sees an error if the email is wrong' do
    visit "/sessions/new"
    fill_in(:email, with: "wrong_email@mail.com")
    fill_in(:password, with: "password123")
    click_button('Sign In')
    
    expect(page).not_to have_content 'Welcome, Test User!'
    expect(page).to have_content 'Please check your email or password'
  end
  scenario 'a user sees an error if their password is wrong' do
     User.create(username: 'Test User 2', email: 'test_user2@mail.com', password: "password123")

     visit '/sessions/new'
     fill_in(:email, with: 'test_user2@mail.com')
     fill_in(:password, with: 'wrong_password')
     click_button('Sign In')

     expect(page).not_to have_content 'Welcome, Test User!'
    expect(page).to have_content 'Please check your email or password'
  end
end