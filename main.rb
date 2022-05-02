
require_relative './naval_models'
require_relative './naval_controller'
require_relative './naval_view'

print "Seleccione dificultad: 1 EASY 2 HARD \n"
key_x = $stdin.gets.to_i
if  key_x==1
  diff =  { 'size' => 10, 'ships' => 5 }
else
  diff =  { 'size' => 15, 'ships' => 8 }
end

game = Game.new(diff)
view = View.new
controller = NavalController.new(game,view)
controller.printBoard
for i in 1..2
  for j in 1..diff["ships"]
      controller.requestShips(i,j)
    end
end