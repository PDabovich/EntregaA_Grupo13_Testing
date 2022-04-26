require 'minitest/autorun'
require_relative '../naval_models.rb'

class GameTest < Minitest::Test
  def test_insert_ship
    easy = { 'size' => 10, 'ships' => 5 }
    game = Game.new(easy)
    game.board1.insert_ship('A1', 'horizontal')
    puts game.board1.cells[0][0].isship
    puts game.board1.cells[0][1].isship
    puts game.board1.cells[0][2].isship
  end

  def test_shoot_block
    easy = { 'size' => 10, 'ships' => 5 }
    game = Game.new(easy)
    game.board1.shoot_block('A1')
    game.board1.shoot_block('A0')
    game.board1.shoot_block('A2')
    puts game.board1.cells[0][0].shot
    puts game.board1.cells[0][1].shot
    puts game.board1.cells[0][2].shot
  end
end
