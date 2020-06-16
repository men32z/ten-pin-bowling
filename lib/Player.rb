class Player
  @@id = 0
  attr_accessor :id, :name
  def initialize(name = false)
    @@id += 1
    self.id = @@id
    self.name = (name || 'player' + id.to_s)
  end
end
