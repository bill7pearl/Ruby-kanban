require_relative 'item'
require_relative 'book'

class Label < Item
  attr_accessor :title, :color
  attr_reader :id, :items

  def initialize(title, color)
    super()
    @id = Random.rand(1..1000)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items.push(item)
    @items << item
    item.label = self
    item.add_label(self)
  end

  def to_h
    {
      id: @id,
      title: @title,
      color: @color
    }
  end
end
