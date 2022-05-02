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

  attr_reader :board1, :board2, :difficulty
end

# Creacion bloque #
class Block
  def initialize(position)
    @position = position
    @shot = false
    @isship = false
    @shipId = 'NaN'
  end
  attr_reader :position, :isship, :shot, :shipId
end

public

def convert_to_ship(shipId)
  @isship = true
  @shipId = shipId
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
    @ships = []
    @toletters = { 0 => 'A', 1 => 'B', 2 => 'C', 3 => 'D', 4 => 'E', 5 => 'F',
                   6 => 'G', 7 => 'H', 8 => 'I', 9 => 'J', 10 => 'K', 11 => 'L',
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
  return false
  end

  # Inserta el barco de ser posible, en la posición indicada, orientación y tamaño
  def insert_ship(position, orientation)
    if verify_insertion(position, orientation)
      puts format('Insertando un barco en %s en orientacion %s', position, orientation)
      index_i = @tonumbers[position[0]]
      index_j = position[1].to_i
      ship_blocks = []
      if orientation == 'horizontal'
        (0..2).each do |n|
          @cells[index_i][index_j - 1 + n].convert_to_ship(position)
          ship_blocks.append([index_i, index_j - 1 + n])
        end
      else
        (0..2).each do |n|
          @cells[index_i - 1 + n][index_j].convert_to_ship(position)
          block_index = [index_i  - 1 + n, index_j]
          ship_blocks.append(block_index)
        end
      end
      @ships.append(ship_blocks)
      return true
    end
    return false
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

    if orientation == 'horizontal'
      j_array = [@cells[index_i][index_j - 1].isship, @cells[index_i][index_j].isship,
                 @cells[index_i][index_j + 1].isship]

      if j_array[0] || j_array[1] || j_array[2]
        return false
      end

    elsif orientation == 'vertical'
      i_array = [@cells[index_i - 1][index_j].isship, @cells[index_i][index_j].isship,
      @cells[index_i + 1][index_j].isship]
      if i_array[0] || i_array[1] || i_array[2]
        return false
      end
    end

    return true
  end

  # simply shoots a block
  def shoot_block(position)
    index_i = @tonumbers[position[0]]
    index_j = position[1].to_i
    if @cells[index_i][index_j].isship && @cells[index_i][index_j].shot == false
      @blocks_to_shoot -= 1
      @cells[index_i][index_j].gets_shoot
      shipId = @cells[index_i][index_j].shipId
      puts format('Ha dado con una seccion de barco en %s !', position)
      sinked_ship_check(shipId)
      return true
    end
    puts 'El tiro no ha dado en un barco'
    false
  end

  # Checks for sinked ship.
  def sinked_ship_check(shipId)
    sinkedBlocks = 0
    @cells.each do |row|
      row.each do |block|
        if block.shot && block.shipId == shipId
          sinkedBlocks += 1
        end
        if sinkedBlocks == 3
          puts 'Has hundido un barco con centro en ' + shipId
          return
        end
      end
    end  
  end

  # Inserts a random ship
  def random_insertion(n)
    inserted = 0
    while inserted < n - 1
      orientation = 'horizontal'
      index_i = @toletters[rand(1..@size - 2)]
      index_j = rand(0..@size - 1).to_s
      if rand(0..1) == 1
        orientation = 'vertical' 
        index_i = @toletters[rand(0..@size - 1)]
        index_j = rand(1..@size - 2).to_s
      end 
      if verify_insertion(index_i + index_j, orientation)
        insert_ship(index_i + index_j, orientation)
        inserted += 1
      end
    end
  end

  def random_shot
    index_i = @toletters[rand(0..@size - 1)]
    index_j = rand(0..@size - 1).to_s
    shoot_block(index_i + index_j)
  end

  attr_reader :cells, :ships
end

# game = Game.new(easy)
# game.board1.insert_ship('J1', 'horizontal')
# puts game.board1.cells[9][1].isship

# Verifying is true
# puts game.board1.cells[0][0].isship
# puts game.board1.cells[0][1].isship
# puts game.board1.cells[0][2].isship

# verifying it gets properly shot
# game.board1.shoot_block('A1')
# game.board1.shoot_block('A0')
# game.board1.shoot_block('A2')
#puts game.board1.cells[0][0].shot
#puts game.board1.cells[0][1].shot
#puts game.board1.cells[0][2].shot

#game.board1.random_insertion(5)
#game.board1.random_shot

#game.board1.sinked_ship_check('A1')