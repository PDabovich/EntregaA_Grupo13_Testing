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

  ### ACTUAL TEST
  def test_limit_invalid_ship_insertion
    #size 10x10 board
    easy = { 'size' => 10, 'ships' => 5 }
    game = Game.new(easy) 

    #Inserts an invalid limit ship
    invalid_insert_output_1 = game.board1.insert_ship('A0', 'horizontal')
    invalid_insert_output_2 = game.board1.insert_ship('A0', 'vertical')
    invalid_insert_output_3 = game.board1.insert_ship('A9', 'horizontal')
    invalid_insert_output_4 = game.board1.insert_ship('A9', 'vertical')
    invalid_insert_output_5 = game.board1.insert_ship('J0', 'horizontal')
    invalid_insert_output_6 = game.board1.insert_ship('J0', 'vertical')
    invalid_insert_output_7 = game.board1.insert_ship('J9', 'horizontal')
    invalid_insert_output_8 = game.board1.insert_ship('J0', 'vertical')
    assert_equal(false, invalid_insert_output_1)
    assert_equal(false, invalid_insert_output_2)
    assert_equal(false, invalid_insert_output_3)
    assert_equal(false, invalid_insert_output_4)
    assert_equal(false, invalid_insert_output_5)
    assert_equal(false, invalid_insert_output_6)
    assert_equal(false, invalid_insert_output_7)
    assert_equal(false, invalid_insert_output_8)
  end

  def test_limit_valid_ship_insertion
    #size 10x10 board
    easy = { 'size' => 10, 'ships' => 5 }
    game = Game.new(easy) 

    #Inserts an valid limit ship
    valid_insert_output_1 = game.board1.insert_ship('A1', 'horizontal')
    valid_insert_output_2 = game.board2.insert_ship('B0', 'vertical')
    valid_insert_output_3 = game.board1.insert_ship('A8', 'horizontal')
    valid_insert_output_4 = game.board2.insert_ship('B9', 'vertical')
    valid_insert_output_5 = game.board1.insert_ship('J1', 'horizontal')
    valid_insert_output_6 = game.board2.insert_ship('H0', 'vertical')
    valid_insert_output_7 = game.board1.insert_ship('J8', 'horizontal')
    valid_insert_output_8 = game.board2.insert_ship('I9', 'vertical')

    assert_equal(true, valid_insert_output_1)
    assert_equal(true, valid_insert_output_2)
    assert_equal(true, valid_insert_output_3)
    assert_equal(true, valid_insert_output_4)
    assert_equal(true, valid_insert_output_5)
    assert_equal(true, valid_insert_output_6)
    assert_equal(true, valid_insert_output_7)
    assert_equal(true, valid_insert_output_8)
  end
end
