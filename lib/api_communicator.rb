require 'rest-client'
require 'json'
require 'pry'

def make_web_request(url)
  all_characters=RestClient.get(url)
  JSON.parse(all_characters)
end

def get_character_movies_from_api(character)
  url = 'http://www.swapi.co/api/people/'
  film_array=[]
  character_hash=make_web_request(url)
  while character_hash["next"] != nil
    character_hash["results"].each do |second_character_hash|
      if second_character_hash["name"].downcase == character
        second_character_hash["films"].each do |film|
          film_api = RestClient.get(film)
          film_json = JSON.parse(film_api)
          film_array.push(film_json)
        end
      end
    end
    character_hash=make_web_request(character_hash["next"])
  end
    character_hash["results"].each do |second_character_hash|
      if second_character_hash["name"].downcase == character
        second_character_hash["films"].each do |film|
          film_api = RestClient.get(film)
          film_json = JSON.parse(film_api)
          film_array.push(film_json)
        end
      end
    end
    return film_array
end

def parse_character_movies(films_hash)
  films_hash.each.with_index(1) do |film, index|
    puts "#{index}. #{film["title"]}"
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

def get_opening_crawl
end
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
