require 'user'

describe 'User' do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(username: 'User2', email: 'user2@email.com', password: "Password123")
      persisted_data = persisted_data(table: 'users', id: user.id)

      expect(user).to be_a User
      expect(user.id).to eq persisted_data.first['id']
      expect(user.username).to eq persisted_data.first['username']
      expect(user.email).to eq 'user2@email.com'
    end
    it 'hashes password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password123')

      User.create(username: "Test1", email: "test@example.com", password: "password123")
    end
  end
  describe '.find' do
    it 'finds a user by ID' do
      user = User.create(username: 'User3', email: 'user3@email.com', password: "Password123")
      result = User.find(user.id)

      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
      expect(result.username).to eq user.username
    end
    it 'returns nil if there is no ID given' do
      expect(User.find(nil)).to eq nil
    end
  end
  describe '.authenticate' do
    it 'returns a user object if email and password given are correct' do
      user = User.create(username: 'User4', email: 'user4@email.com', password: 'Password123')
      authenticated_user = User.authenticate(email: 'user4@email.com', password: 'Password123')

      expect(authenticated_user.id).to eq user.id
    end
    it 'returns nil when incorrect email is given' do
      user = User.create(username: 'User5', email: 'user5@email.com', password: 'Password123')

      expect(User.authenticate(email: 'wrong@email.com', password: 'password123')).to be_nil
    end
  end
end
