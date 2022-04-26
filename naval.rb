toletters = { 1 => 'A', 2 => 'B', 3 => 'C', 4 => 'D', 5 => 'E', 6 => 'F',
              7 => 'G', 8 => 'H', 9 => 'I', 10 => 'J', 11 => 'K', 12 => 'J',
              13 => 'M', 14 => 'N', 15 => 'O' }
tonumbers = {}
toletters.each do |key, value|
  tonumbers[value] = key
end

easy = { 'size' => 10, 'ships' => 5 }
hard = { 'size' => 15, 'ships' => 8 }

# Creacion de juego #
class Game
  def initialize(diff)
    @difficulty = diff
    board_create
  end

  def board_create
    @board1 = Board.new(@difficulty['size'], @difficulty['ships'])
    @board2 = Board.new(@difficulty['size'], @difficulty['ships'])
  end
end

# Creacion bloque #
class Block
  def initialize(position)
    @position = position
    @shot = false
    @isship = false
  end
end

# Creacion tablero #
class Board
  def initialize(size, ships_number)
    @size = size
    @ships_number = ships_number
    @cells = []
    @ships = {}
    cells_create
  end

  def cells_create
    i = 0
    while i < @size
      j = 0
      while j < @size
        block = Block.new([i, j])
        @cells.append(block)
        j += 1
      end
      i += 1
    end
  end

  def insert_ship(position, orientation, ship_size)
    if verify_insertion(position, orientation, ship_size)
      if orientation == 'horizontal'
        i = 0
        while i < ship_size
          @cells[]
        end
      end
    end
  end
  
  def verify_insertion
  end

end

Game.new(easy)
Game.new(hard)
