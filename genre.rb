class Genre
    attr_reader :name, :items

  def initialize(name)
    @id = Random.new.rand(1..1000)
    @name = name
    @items = []
  end
end
