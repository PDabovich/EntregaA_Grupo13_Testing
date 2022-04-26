pieces = { 'side' => '│', 'topbot' => '─', 'tl' => '┌', 'tr' => '┐',
           'bl' =>'└', 'br' => '┘', 'lc' => '├', 'rc' => '┤',
           'tc' => '┬', 'bc' => '┴', 'crs' => '┼' }

class NavalController
  def initialize(nGame, nView)
    @model = nGame
    @view = nView
  end


  def printBoard
    #@view.clean
    @view.printBoard(@model)
  end

  def requestShips(player,ship)
    print "Jugador #{player} inserte la posicion X del barco n°#{ship} X\n"
    key_x = $stdin.gets
    print "Jugador #{player} inserte la posicion Y del barco n°#{ship} X\n"
    key_y = $stdin.gets
    print "Jugador #{player} inserte la orientacion del barco n°#{ship} (H para horizontal, V para vertical) X\n"
    orient = $stdin.gets
    if orient == "H"
      orienta = 'horizontal'
    else
      orienta = 'vertical'
    end
    position =   "#{key_x}" + "#{key_y}"
    print position
    @model.board1.insert_ship(position, orienta)
  end
end
