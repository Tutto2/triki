class Triki
  attr_accessor :table, :mark, :player_name_one, :player_name_two
  attr_reader :counter
  
  def initialize(player_name_one, player_name_two)
    @table = [[""]*3, [""]*3, [""]*3]
    @player_name_one = player_name_one
    @player_name_two = player_name_two
    @counter = 2
    @symbol = which_symbol
  end

  def title
    "Turno #{@counter-1} - #{(@counter%2 == 0) ? @player_name_one : @player_name_two}, elige el numero de la posicion que deseas: "
  end

  def attempt(mark)
    if is_ocupated?(mark)
      puts "Intenta nuevamente"
      return
    else
      write(mark)
      @counter += 1
      @symbol = which_symbol
    end
    return @table
  end

  def win?
    first_row_eql? || second_row_eql? || third_row_eql? ||
    first_col_eql? || second_col_eql? || third_col_eql? ||
    first_diag_eql? || second_diag_eql?
  end

  def game_over?
    !table.flatten.any?(&:empty?)
  end

  def which_symbol
    if @counter%2 == 0 
      "o"
    else
      "x"
    end
  end

  def is_ocupated?(mark)
    case 
    when mark == 1
      !@table[0][0].empty?
    when mark == 2
      !@table[0][1].empty?
    when mark == 3
      !@table[0][2].empty?
    when mark == 4
      !@table[1][0].empty?
    when mark == 5
      !@table[1][1].empty?
    when mark == 6
      !@table[1][2].empty?
    when mark == 7
      !@table[2][0].empty?
    when mark == 8
      !@table[2][1].empty?
    when mark == 9
      !@table[2][2].empty?
    else
      true
    end
  end

  def write(mark)
    case mark
    when 1
      @table[0][0] = @symbol
    when 2
      @table[0][1] = @symbol
    when 3
      @table[0][2] = @symbol
    when 4
      @table[1][0] = @symbol
    when 5
      @table[1][1] = @symbol
    when 6
      @table[1][2] = @symbol
    when 7
      @table[2][0] = @symbol
    when 8
      @table[2][1] = @symbol
    when 9
      @table[2][2] = @symbol
    end
  end

  def to_s
    str = ""
    3.times do |i|
      3.times do |j|
        str << "\t#{@table[i][j]}\t#{j < 2 ? '|' : ''}"
      end
      str << "\n#{i < 2 ? '------------'*4 : ''}\n"
    end
    str
  end

  private
  def first_row_eql?
    (@table[0][0] == @table[0][1]) && (@table[0][0] == @table[0][2]) && !@table[0][0].empty?
  end

  def second_row_eql?
    (@table[1][0] == @table[1][1]) && (@table[1][0] == @table[1][2]) && !@table[1][0].empty?
  end

  def third_row_eql?
    (@table[2][0] == @table[2][1]) && (@table[2][0] == @table[2][2]) && !@table[2][0].empty?
  end

  def first_col_eql?
    (@table[0][0] == @table[1][0]) && (@table[0][0] == @table[2][0]) && !@table[0][0].empty?
  end

  def second_col_eql?
    (@table[0][1] == @table[1][1]) && (@table[0][1] == @table[2][1]) && !@table[0][1].empty?
  end

  def third_col_eql?
    (@table[0][2] == @table[1][2]) && (@table[0][2] == @table[2][2]) && !@table[0][2].empty?
  end

  def first_diag_eql?
    (@table[0][0] == @table[1][1]) && (@table[0][0] == @table[2][2]) && !@table[0][0].empty?
  end

  def second_diag_eql?
    (@table[0][2] == @table[1][1]) && (@table[0][2] == @table[2][0]) && !@table[0][2].empty?
  end
end

print "Elige el nombre del primer jugador: "
player_name_one = gets.chomp.to_s
print "Elige el nombre del segundo jugador: "
player_name_two = gets.chomp.to_s
game = Triki.new(player_name_one, player_name_two)
loop do
  puts game
  if game.win?
    puts "Felicidades #{(game.counter%2 == 0) ? game.player_name_two : game.player_name_one}, has ganado!"
  elsif game.game_over?
    puts "No mas movimientos, han empatado"  
  end
  break if (game.game_over? || game.win?)
  print game.title
  mark = gets.chomp.to_i
  game.attempt(mark)
end