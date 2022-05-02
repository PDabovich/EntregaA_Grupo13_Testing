def upper(boxlen, draw, pieces, row, rowindex)
row.each_with_index do |col, colindex|
if rowindex == 0
colindex == 0 ? start = pieces['tl'] : start = pieces['tc']
draw << start + (pieces['topbot']*boxlen)
colindex == row.length - 1 ? draw << pieces['tr'] : ""
end
end
draw << "\n" if rowindex == 0
end

def middle(boxlen, draw, pieces, row)
row.each do |col|
draw << pieces['side'] + col.to_s.center(boxlen)
end
draw << pieces['side'] + "\n"
end

def bottom(args, boxlen, draw, pieces, row, rowindex)
row.each_with_index do |col, colindex|
if colindex == 0
rowindex == args.length - 1 ? draw << pieces['bl'] : draw << pieces['lc']
draw << (pieces['topbot']*boxlen)
else
rowindex == args.length - 1 ? draw << pieces['bc'] : draw << pieces['crs']
draw << (pieces['topbot']*boxlen)
end
endchar = rowindex == args.length - 1 ? pieces['br'] : pieces['rc']
if args[rowindex+1]
if args[rowindex+1].length < args[rowindex].length
endchar = pieces['br']
end
end
colindex == row.length - 1 ? draw << endchar : ""
end
draw << "\n"
end

def drawgrid(args, boxlen = 3, pieces, diff)
draw = []
indice = '   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O'
draw << '  '
args.each_with_index do |row, rowindex|
upper(boxlen, draw, pieces, row, rowindex)
draw << ' ' if rowindex < 10
draw << rowindex
middle(boxlen, draw, pieces, row)
draw << '  '
bottom(args, boxlen, draw, pieces, row, rowindex)
end
puts ' ' + indice[0,diff*4]
draw.each do |char|
print char
end
return true
end

class View
    def initialize()
        @tablero = []
        @diff = 0
        @pieces = { 'side' => '│', 'topbot' => '─', 'tl' => '┌', 'tr' => '┐',
            'bl' =>'└', 'br' => '┘', 'lc' => '├', 'rc' => '┤',
            'tc' => '┬', 'bc' => '┴', 'crs' => '┼' }
        @toletters = { 0 => 'A', 1 => 'B', 2 => 'C', 3 => 'D', 4 => 'E', 5 => 'F',
            6 => 'G', 7 => 'H', 8 => 'I', 9 => 'J', 10 => 'K', 11 => 'L',
            12 => 'M', 13 => 'N', 14 => 'O' }
        @tonumbers = {}
        @toletters.each do |key, value|
        @tonumbers[value] = key
        end
    end
    def printBoard(boardModel)
        @diff = boardModel.difficulty['size']
        for i in 1..@diff
            fila = []
            for j in 1..@diff
                fila << ' '
            end
            @tablero << fila
        end
        drawgrid(@tablero, @pieces, @diff)
    end
    def actualizarTablero(position, tipo)
        @tablero[position[1].to_i][@tonumbers[position[0]]] = 'B' if tipo == 'B'
        @tablero[position[1].to_i][@tonumbers[position[0]]] = 'X' if tipo == 'X'
        @tablero[position[1].to_i][@tonumbers[position[0]]] = 'O' if tipo == 'O'
        drawgrid(@tablero, @pieces, @diff)
    end
end
