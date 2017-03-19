require_relative 'life_counter'
require_relative 'word'

# Game class
class Game
  def initialize
    @life_counter = LifeCounter.new
    @word = Word.new
    # Home work
    @input_array = []
  end

  def run
    game_loop
    check_result
  end

  private

  def game_loop
    loop do
      announce_game_state

      user_char = read_input

      # Home work
      unless input_valid?(user_char)
        puts 'Your input is invalid! Please try again.'
        next
      end

      # Home work
      next if char_repeat?(user_char)

      guessed = @word.char_exists?(user_char)

      if guessed
        break if @word.finished?
      else
        @life_counter.decrement
        break if @life_counter.dead?
      end
    end
  end

  def announce_game_state
    puts "Your life total is #{@life_counter.life_count}"
    puts "Your word is #{@word.visible_word}"
  end

  def read_input
    puts 'Enter your char:'
    gets.chomp!.to_s
  end

  def check_result
    if @word.finished?
      puts 'You are victorious!'
    else
      puts 'You are dead...'
    end

    puts "Your word is #{@word.secret_word}"
  end

  # Home work
  def input_valid?(user_char)
    flag = true
    if user_char.length > 1
      flag = false
    elsif user_char == '!'
      flag = false
    end

    flag
  end

  # Home work
  def char_repeat?(char)
    flag = false
    if @input_array.include?(char)
      puts 'You have entered this char earlier! Please, try another one!'
      flag = true
    else
      @input_array.push(char)
    end
    flag
  end
end
