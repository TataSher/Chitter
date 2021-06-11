feature 'adding and viewing comments' do
  feature 'a user can add and then view comments' do
    scenario ' a comment is added to a peep' do
      peep = Peep.create(peep: 'First Peep')
      
      visit '/peeps'
      first('.peep').click_button 'Comment'

      expect(current_path).to eq "/peeps/#{peep.id}/comments/new"

      fill_in 'comment', with: 'Test Comment'
      click_button 'Comment'

      expect(current_path).to eq "/peeps"
      expect(first('.peep')).to have_content('Test Comment')
    end
  end
end
