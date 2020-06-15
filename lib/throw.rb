# frozen_string_literal: true

class Throw
  attr_reader :name, :shoot
  def initialize(name, shoot)
    @name = name
    @shoot = shoot
  end
end
