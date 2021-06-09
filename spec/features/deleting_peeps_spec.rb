require_relative '../setup_test_database'

feature 'Deleting peeps' do
  scenario 'A user can delete a peep' do
    add_peeps
    visit('/peeps')
    expect(page).to have_content('First Peep')

    first(".peep").click_button 'Delete'

    expect(current_path).to eq('/peeps')
    expect(page).not_to have_content('First Peep')
  end
end