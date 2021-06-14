feature 'adding and viewing tags' do
  feature 'a user can add and view tags on peeps' do
      scenario 'a tag is added to a peep' do
      peep = Peep.create(peep: 'First Peep')

      visit '/peeps'
      first('.peep').click_button 'Tag'

      expect(current_path).to eq "/peeps/#{peep.id}/tags/new"

      fill_in 'tag', with: 'Test Tag'
      click_button 'Tag'

      expect(current_path).to eq "/peeps"
      expect(first('.peep')).to have_content('Test Tag')
    end
  end
end