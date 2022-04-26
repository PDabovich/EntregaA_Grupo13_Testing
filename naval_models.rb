# frozen_string_literal: true

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

  attr_reader :board1, :board2
end

# Creacion bloque #
class Block
  def initialize(position)
    @position = position
    @shot = false
    @isship = false
  end
  attr_reader :position, :isship, :shot
end

public

def convert_to_ship
  @isship = true
end

public

def gets_shoot
  @shot = true
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
    @blocks_to_shoot = if size == 10

                         # Si alguno de estos atributos llega a 0 el juego termina con el oponente ganando
                         # 5 boats
                         9
                       else
                         # 3 boats
                         15
                       end

    cells_create
  end

  # Ayuda a crear bloques en el inicio del juego
  def cells_create
    i = 0
    while i < @size
      j = 0
      temp = []
      while j < @size
        # Lo traducimos a index Letrado
        lettered_index = @toletters[i]
        block = Block.new([lettered_index, j])
        temp.append(block)
        j += 1
      end
      @cells.append(temp)
      i += 1
    end
  end

  # Si retorna true, el jugado de esta tabla ha perdido.
  def lost_board
    return true if @blocks_to_shoot.zero?
  end

  # Inserta el barco de ser posible, en la posición indicada, orientación y tamaño
  def insert_ship(position, orientation)
    if verify_insertion(position, orientation)
      puts format('Insertando un barco en %s en orientacion %s', position, orientation)
      index_i = @tonumbers[position[0]]
      index_j = position[1].to_i
      if orientation == 'horizontal'
        (0..2).each do |n|
          @cells[index_i][index_j - 1 + n].convert_to_ship
        end
      else
        (0..2).each do |n|
          @cells[index_i - 1 + n][index_j].convert_to_ship
        end
      end
    end
  end

  # Verifica que el barco pueda ser insertado en el lugar propuesto
  def verify_insertion(position, orientation)
    index_i = @tonumbers[position[0]]
    index_j = position[1].to_i

    if orientation == 'horizontal' && (index_j < 1 || index_j > @size - 2)
      return false

    elsif orientation == 'vertical' && (index_i < 1 || index_i > @size - 2)
      return false
    end

    i_array = [@cells[index_i - 1][index_j].isship, @cells[index_i][index_j].isship,
               @cells[index_i + 1][index_j].isship]
    j_array = [@cells[index_i][index_j - 1].isship, @cells[index_i][index_j].isship,
               @cells[index_i][index_j + 1].isship]

    if orientation == 'horizontal' && (j_array[0] || j_array[1] || j_array[2])
      return false

    elsif orientation == 'vertical' && (i_array[0] || i_array[1] || j_array[2])
      return false
    end

    true
  end

  # simply shoots a block
  def shoot_block(position)
    index_i = @tonumbers[position[0]]
    index_j = position[1].to_i
    if @cells[index_i][index_j].isship && @cells[index_i][index_j].shot == false
      @blocks_to_shoot -= 1
      @cells[index_i][index_j].gets_shoot
      return true
    end
    false
  end

  def cells_at(xo,yo)
    @cells[xo][yo]
  end
  attr_reader :cells
end

#game = Game.new(easy)
#game.board1.insert_ship('A1', 'horizontal')

# Verifying is true
#puts game.board1.cells[0][0].isship
#puts game.board1.cells[0][1].isship
#puts game.board1.cells[0][2].isship

# verifying it gets properly shot
#game.board1.shoot_block('A1')
#game.board1.shoot_block('A0')
#game.board1.shoot_block('A2')
#puts game.board1.cells[0][0].shot
#puts game.board1.cells[0][1].shot
#puts game.board1.cells[0][2].shot
