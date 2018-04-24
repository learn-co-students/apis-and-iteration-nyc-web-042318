require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  empty_array = []

  character_hash["results"].map do |hash|

    hash["films"].map do |film|
        all_movies = RestClient.get(film)

        movie_array = JSON.parse(all_movies)
        movie_array["title"]
        movie_hash = {movie_array["title"] => film}
        empty_array << movie_hash
        #binding.pry
#binding.pry
    #binding.pry



    end
  end
  empty_array = empty_array.uniq
#binding.pry
end

# def get_movie(character)
#   all_characters = RestClient.get('http://www.swapi.co/api/people/')
#   character_hash = JSON.parse(all_characters)
#
#   character_hash["results"].map do |hash|
#     hash["films"].map do |film|
#       all_movies = RestClient.get(film)
#       binding.pry
#     end
#   end
# end


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
count = 1
  films_hash.map do |title, api|
    puts "#{count} #{title.keys.join(" ")}"
    count += 1
    end


    #binding.pry
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
