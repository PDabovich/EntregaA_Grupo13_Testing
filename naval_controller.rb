class NavalController
    def initialize(nGame, nView)
        @model = nGame
        @view = nView
    end


    def printBoard
        @view.printBoard(@model)
    end

    def verifyResponse(valor)
        

    def requestShips(player,ship)
        key_x = ' '
        key_y = ' '
        while verifyResponse(key_x[0,1], @model.difficulty['size']) 
            print "Jugador #{player} inserte la posicion X del barco n°#{ship} X\n"
            key_x = $stdin.gets
        end
        print "Jugador #{player} inserte la posicion Y del barco n°#{ship} X\n"
        key_y = $stdin.gets
        print "Jugador #{player} inserte la orientacion del barco n°#{ship} (H para horizontal, V para vertical) X\n"
        orient = $stdin.gets
        if orient[0,1] == "H"
        orienta = 'horizontal'
        else
        orienta = 'vertical'
        end
        position = key_x[0,1] + key_y[0,1]
        if @model.board1.verify_insertion(position, orienta)
            @model.board1.insert_ship(position, orienta)
            @view.actualizarTablero(position, 'B')
        else
            puts 'posición no válida'
        end
    end
end