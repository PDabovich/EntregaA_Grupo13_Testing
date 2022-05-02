class NavalController
    def initialize(nGame, nView)
        @model = nGame
        @view = nView
        @model.board2.random_insertion(@model.difficulty['ships'])
    end


    def printBoard
        @view.printBoard
    end

    def verifyResponse(valor, size)
        options = 'ABCDEFGHIJKLMNO'
        if options[0,size].include?(valor[0]) && valor[1].to_i < size
            true
        else
            puts "Error de sintaxis \n"
            false
        end
    end

    def requestShips(ship)
        while true
            print "Jugador inserte la posicion del barco n°#{ship} (Ej: A1)\n"
            key = $stdin.gets
            break if verifyResponse(key[0,2], @model.difficulty['size'])
        end
        print "Jugador inserte la orientacion del barco n°#{ship} (H para horizontal, V para vertical) \n"
        orient = $stdin.gets
        if orient[0,1] == "H"
        orienta = 'horizontal'
        else
        orienta = 'vertical'
        end
        position = key[0,2]
        if @model.board1.verify_insertion(position, orienta)
            @model.board1.insert_ship(position, orienta)
            @view.mostrarBarcos(position, orienta)
        else
            puts 'posición no válida'
        end
    end

    def playGame
        while true
        break if @model.board1.blocks_to_shoot == 0
        break if @model.board2.blocks_to_shoot == 0
        @view.printTablero_juego
        while true
        print "Jugador inserte la posicion donde desea disparar (Ej: A1)\n"
            key = $stdin.gets
        break if verifyResponse(key[0,2], @model.difficulty['size'])
        end
        if @model.board2.shoot_block(key[0,2])
            @view.actualizarTablero(key[0,2], 'O')
        else
            @view.actualizarTablero(key[0,2], 'X')
        end
        @model.board1.random_shot
        end
        @view.printTablero_juego
        puts "FELICITACIONES HAS HUNDIDO TODOS LOS BARCOS ENEMIGOS" if @model.board2.blocks_to_shoot == 0
        puts "Te han derrotado, mejor suerte para la próxima" if @model.board1.blocks_to_shoot == 0
    end
end
