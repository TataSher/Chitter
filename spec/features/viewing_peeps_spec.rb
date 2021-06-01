# frozen_string_literal: true

feature 'Viewing Peeps' do
  scenario 'A user can visit index page' do
    visit('/')
    expect(page).to have_content 'Chitter'
  end

  scenario 'A user can see peeps' do
    visit('/peeps')
    
    expect(page).to have_content 'First Peep'
    expect(page).to have_content 'Second Peep'
    expect(page).to have_content 'Third Peep'
  end
end
