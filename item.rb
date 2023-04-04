require 'date'

class Item
    attr_reader :id, :genre, :author, :source, :label, :publish_date, :archived

  def initialize(id = Random.rand(1..1000))
    @id = id
    @genre = nil
    @author = nil
    @source = nil
    @label = nil
    @publish_date = nil
    @archived = false
  end
end