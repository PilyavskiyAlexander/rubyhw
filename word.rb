# Word class
class Word
  attr_reader :visible_word, :secret_word

  def initialize
    @secret_word = get_secret_word
    @visible_word = get_visible_word(@secret_word)
  end

  def choose_rubric
    puts 'Choose rubric:'
    # Can choose from this methods
    # puts Faker::StarWars.methods(false).each { |r|  puts r }
    rubric_array = %w(character planet quote specie vehicle)
    rubric_array.each { |r| puts r }
    gets.chomp!.to_s
  end

  def get_secret_word
    rubric = choose_rubric
    case rubric
    when 'character'
      return Faker::StarWars.character.downcase
    when 'planet'
      return Faker::StarWars.planet.downcase
    when 'quote'
      return Faker::StarWars.quote.downcase
    when 'specie'
      return Faker::StarWars.specie.downcase
    when 'vehicle'
      return Faker::StarWars.vehicle.downcase
    else
      puts 'There are not such rubric! Try another!'
      get_secret_word
    end
  end

  def char_exists?(char)
    indexes = find_indexes(char)

    update_visible_word(indexes, char)

    !indexes.empty?
  end

  def finished?
    !@visible_word.include?('_')
  end

  def update_visible_word(indexes, char)
    indexes.each do |index|
      @visible_word[index] = char
    end
  end

  def find_indexes(char)
    indexes = []

    @secret_word.split('').each_with_index do |symbol, index|
      indexes << index if symbol == char
    end

    indexes
  end

  # Home work
  def get_visible_word(secret_word)
    secret_word.gsub(/[a-zA-Z0-9-]/) { '_' }
  end
end
