class Player
  @@id = 0;
  attr_accessor :id, :name
  def initialize(name = false)
    @@id +=1
    self.id = @@id
    if name
      self.name = name
    else
      self.name = 'player' + self.id.to_s
    end
  end
end