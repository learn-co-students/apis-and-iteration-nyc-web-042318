def welcome
  # puts out a welcome message here!
  puts "Welcome to the game."
end

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  gets.chomp.downcase
end

# def get_movie_from_user
#   user_input = gets.chomp
# end
