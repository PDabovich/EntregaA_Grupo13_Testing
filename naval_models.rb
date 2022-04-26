toletters = { 0 => 'A', 1 => 'B', 2 => 'C', 3 => 'D', 4 => 'E', 5 => 'F',
              6 => 'G', 7 => 'H', 8 => 'I', 9 => 'J', 10 => 'K', 11 => 'J',
              12 => 'M', 13 => 'N', 14 => 'O' }
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

  attr_reader :board1
  attr_reader :board2
end

# Creacion bloque #
class Block
  def initialize(position)
    @position = position
    @shot = false
    @isship = false
  end
  attr_reader :position
end

# Creacion tablero #
class Board
  def initialize(size, ships_number)
    @size = size
    @ships_number = ships_number
    @cells = []
    @ships = {}
    @toletters = { 0 => 'A', 1 => 'B', 2 => 'C', 3 => 'D', 4 => 'E', 5 => 'F',
      6 => 'G', 7 => 'H', 8 => 'I', 9 => 'J', 10 => 'K', 11 => 'J',
      12 => 'M', 13 => 'N', 14 => 'O' }
    @tonumbers = {}
    @toletters.each do |key, value|
      @tonumbers[value] = key
    end

    cells_create
  end

  def cells_create
    i = 0
    while i < @size
      j = 0
      temp = []
      while j < @size
        #Lo traducimos a index Letrado
        lettered_index = @toletters[i]
        block = Block.new([i, j])
        temp.append(block)
        j += 1
      end
      @cells.append(temp)
      i += 1
    end
  end

  #Inserta el barco de ser posible, en la posición indicada, orientación y tamaño
  def insert_ship(position, orientation)
    if verify_insertion(position, orientation)
      if orientation == 'horizontal'
        i = 0
        while i < 3
          @cells[]
        end
      end
    end
  end
  
  #Verifica que el barco pueda ser insertado en el lugar propuesto
  def verify_insertion(position, orientation)
    index_i = @tonumbers[position[0]]
    index_j = position[1].to_i

    if orientation == 'horizontal' && (index_j <1 || index_j > @size - 2)
      return false

    elsif orientation == 'vertical' && (index_i <1 || index_i > @size - 2)
      return false
    end
  return true
  end
  attr_reader :cells
end




game = Game.new(easy).board1.verify_insertion('A0', 'horizontal')
puts game
