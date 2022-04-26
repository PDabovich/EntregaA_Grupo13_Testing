

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
  attr_reader :isship
  attr_reader :isshot
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
    if size == 10

    #Si alguno de estos atributos llega a 0 el juego termina con el oponente ganando
      #5 boats
      @blocks_to_shoot = 9
    else
      #3 boats
      @blocks_to_shoot = 15
    end

    cells_create
  end

  #Ayuda a crear bloques en el inicio del juego
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

  #Si retorna true, el jugado de esta tabla ha perdido.
  def lost_board
    if @blocks_to_shoot = 0
      return true
    end
  end

  #Inserta el barco de ser posible, en la posición indicada, orientación y tamaño
  def insert_ship(position, orientation)
    if verify_insertion(position, orientation)
      index_i = @tonumbers[position[0]]
      index_j = position[1].to_i
    end
      if orientation == 'horizontal'
        (0..2).each do |n|
          @cells[index_i][index_j - 1 + n].isship = true
        end
      else
        (0..2).each do |n|
          @cells[index_i  - 1 + n][index_j].isship = true
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

    i_array = [@cells[index_i - 1][index_j].isship, @cells[index_i][index_j].isship, @cells[index_i + 1][index_j].isship]
    j_array = [@cells[index_i][index_j - 1].isship, @cells[index_i][index_j].isship, @cells[index_i][index_j +1].isship]

    if orientation == 'horizontal' && (j_array[0] || j_array[1] || j_array[2])
      return false

    elsif orientation == 'vertical' && (i_array[0] || i_array[1] || j_array[2])
      return false
    end
  return true
  end

  def shoot_block(position)
    index_i = @tonumbers[position[0]]
    index_j = position[1].to_i
    if @cells[index_i][index_j].isship && @cells[index_i][index_j].isshot
      @blocks_to_shoot -= 1
      return true
    end
    return false
  end



attr_reader :cells
end

game = Game.new(easy).board1.verify_insertion('I1', 'vertical')
puts game
