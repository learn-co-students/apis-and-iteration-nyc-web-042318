require 'rest-client'
require 'json'
require 'pry'


def get_movie_array(url_list)
 movie_array = []
 url_list.each do |url|
   movie = RestClient.get(url)
   movie_array << JSON.parse(movie)
 end

 movie_array
end


def make_request(url)
  #make the web request
  all_characters = RestClient.get(url)
  JSON.parse(all_characters)
end


def get_character_movies_from_api(character)
  url = 'http://www.swapi.co/api/people/'

  character_hash = make_request(url)

  all_character_hashes = []

  while character_hash["next"] != nil
    all_character_hashes << character_hash
    character_hash = make_request(character_hash["next"])
  end

  all_character_hashes << character_hash

  url_array = []
  all_character_hashes.map do |hashes|
    hashes["results"].map do |array|
      array.map do |key, value|
        #binding.pry
        if key == "name" && value.downcase == character.downcase
          url_array = array["films"]
        end
      end
    end
  end

  get_movie_array(url_array)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end


def parse_character_movies(films_hash)
  films_hash.map do |film|
    film.map do |key, value|
      if key == "title"
        puts "#{films_hash.index(film)+1} #{value}"
      end
    end
  end
  # some iteration magic and puts out the movies in a nice list
end


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  if films_hash == []
    puts "Not a character! Try again."
    new_character = gets.chomp
    show_character_movies(new_character)
  else
    parse_character_movies(films_hash)
  end
end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
