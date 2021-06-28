require_relative './database_connection.rb'


class Tag
  
  def self.create(content:)
    if check_content(content: content)
      @result[0]
    else
      result = DatabaseConnection.query("INSERT INTO tags (content) VALUES('#{content}') RETURNING id, content;")
      Tag.new(
        id: result[0]['id'],
        content: result[0]['content']
      )
    end
  end

  def self.where(peep_id:)
    result = DatabaseConnection.query("SELECT * FROM peeptags INNER JOIN tags ON peeptags.tag_id = tags.id WHERE peeptags.peep_id = '#{peep_id}';")
    result.map do |tag|
      Tag.new(id: tag['id'], content: tag['content'])
    end
  end
  attr_reader :id, :content

  def initialize(id:, content:)
    @id = id
    @content = content
  end

  def self.check_content(content:)
    @result = DatabaseConnection.query("SELECT * FROM tags WHERE content = '#{content}';")
    @result.map do |tag|
      @content = tag['content']
    end
      @content == content
  end
end