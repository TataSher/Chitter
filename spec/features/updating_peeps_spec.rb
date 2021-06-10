feature 'Updating peeps' do
  scenario 'A user can update a peep' do
    peep = Peep.create(peep: 'First Peep')
    
    visit('/peeps')
    expect(page).to have_content('First Peep')

    first(".peep").click_button 'Edit'
    expect(current_path).to eq("/peeps/#{peep.id}/edit")
    
    fill_in 'peep' , with: 'Amended'
    click_on 'Peep'
    
    expect(current_path).to eq '/peeps'
    expect(page).not_to have_content('First Peep')
    expect(page).to have_content('Amended')
  end
end