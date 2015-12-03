$last_error = nil
require_relative 'computer_player.rb'
class Player
  attr_reader :display, :color

  def initialize(display, color)
    @display = display
    @color = color
  end

  def take_turn
    display.select_piece(color)
    display.move_piece(color)

  rescue InvalidMove => e
    $last_error =  e.message
    retry
  end

end

