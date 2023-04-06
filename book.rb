require_relative 'item'
require_relative 'label'

class Book < Item
  attr_reader :id
  attr_accessor :publisher, :cover_state, :labels, :archived

  def initialize(publisher, cover_state, labels: [], archived: false, id: nil)
    super()
    @id = id || Random.rand(1..1000)
    @publisher = publisher
    @cover_state = cover_state
    @labels = labels
    @archived = archived
  end

  def can_be_archived?
    @archived = super || @cover_state == 'bad'
  end

  def add_label(label)
    @labels << label
  end

  def to_h
    {
      id: @id,
      publisher: @publisher,
      cover_state: @cover_state,
      labels: @labels.map(&:to_h),
      archived: @archived
    }
  end
end
