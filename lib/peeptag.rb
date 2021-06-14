require_relative './database_connection'

class Peeptag
   
  def self.create(peep_id:, tag_id:)
    result = DatabaseConnection.query("INSERT INTO peeptags (peep_id, tag_id) VALUES('#{peep_id}', '#{tag_id}') RETURNING id, peep_id, tag_id;")
    Peeptag.new(
      id: result[0]['id'],
      peep_id: result[0]['peep_id'],
      tag_id: result[0]['tag_id']
    )
  end

  attr_reader :id, :peep_id, :tag_id

  def initialize(id:, peep_id:, tag_id:)
    @id = id
    @peep_id = peep_id
    @tag_id = tag_id
  end
end
