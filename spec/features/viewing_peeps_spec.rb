# frozen_string_literal: true
require_relative '../setup_test_database'

feature 'Viewing Peeps' do
  scenario 'A user can visit index page' do
    visit('/')
    expect(page).to have_content 'Chitter'
  end

  scenario 'A user can see peeps' do
    add_peeps
    visit('/peeps')
    expect(page).to have_content 'First Peep'
    expect(page).to have_content 'Second Peep'
    expect(page).to have_content 'Third Peep'
  end
end
