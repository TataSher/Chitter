feature 'Posting Peeps' do
  scenario 'A user can post a peep' do
    visit('/peeps')
    click_on 'Peep'
    fill_in 'enter_peep' , with: 'First Peep'
    click_on 'Peep'

    expect(page).to have_content('First Peep')
    
  end
end