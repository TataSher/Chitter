require 'database_connection'

describe DatabaseConnection do
  describe '.setup' do
    it 'sets up a connection to a database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'chitter_db_test')
      
      DatabaseConnection.setup('chitter_db_test')
    end
    it 'connection is persistent' do
      connection = DatabaseConnection.setup('chitter_db_test')

      expect(DatabaseConnection.connection).to eq connection
    end
  end
end