pieces = { 'side' => '│', 'topbot' => '─', 'tl' => '┌', 'tr' => '┐',
           'bl' =>'└', 'br' => '┘', 'lc' => '├', 'rc' => '┤',
           'tc' => '┬', 'bc' => '┴', 'crs' => '┼' }

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

def drawgrid(args, boxlen = 3, pieces)
  draw = []
  args.each_with_index do |row, rowindex|
    upper(boxlen, draw, pieces, row, rowindex)
    middle(boxlen, draw, pieces, row)
    bottom(args, boxlen, draw, pieces, row, rowindex)
  end
  draw.each do |char|
    print char
  end
  return true
end

class View
  def printinitialBoard()
    pieces = { 'side' => '│', 'topbot' => '─', 'tl' => '┌', 'tr' => '┐',
               'bl' =>'└', 'br' => '┘', 'lc' => '├', 'rc' => '┤',
               'tc' => '┬', 'bc' => '┴', 'crs' => '┼' }
    drawgrid([[123,456,789,'baz'], ['abc','def','ghi', 'X'], ['foo', 'bar', '0'], ['buz', 'X', 'X']], pieces)
  end
  def printBoard(boardModel)
    pieces = { 'side' => '│', 'topbot' => '─', 'tl' => '┌', 'tr' => '┐',
               'bl' =>'└', 'br' => '┘', 'lc' => '├', 'rc' => '┤',
               'tc' => '┬', 'bc' => '┴', 'crs' => '┼' }
    #print boardModel.return_board_1.cells_at(1,1)
    drawgrid([[123,456,789,'baz'], ['abc','def','ghi', 'X'], ['foo', 'bar', '0'], ['buz', 'X', 'X']], pieces)

  end

end
