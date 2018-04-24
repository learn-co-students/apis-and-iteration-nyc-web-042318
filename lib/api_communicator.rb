require 'rest-client'
require 'json'
require 'pry'


def make_request(url)
  movie_data = {}
  link = RestClient.get(url)
  movie_data = JSON.parse(link)
end

def get_character_movies_from_api(character)
 url = 'http://www.swapi.co/api/people/'
 char_page = make_request(url)
 #entire page

 all_char_hashes =[]

 while char_page["next"] != nil
   #until it finds the name or theres no next
   all_char_hashes << char_page
   char_page = make_request(char_page["next"])
 end
 all_char_hashes << char_page
 #adds last page

 results_array = []
 all_char_hashes.each do |character_hash|
   ## if character_hash["name"] == character
   results_array << character_hash["results"]
   #results_array is an array of character hashes
 end


 film_urls = []
 results_array = results_array.flatten
 while film_urls.length == 0
   results_array.each do |x|
     if x["name"] == character
       film_urls << x["films"]
     end
   end

   if film_urls.length == 0
     puts "not a character"
     character = get_character_from_user
   end
 end

 film_urls = film_urls.flatten

 movie_data = []
 #an array of hashes describing movies
 i = 0

 while i < film_urls.length
   link = RestClient.get(film_urls[i])
   movie_data << JSON.parse(link)
   i+= 1
 end
 movie_data
end







 #make the web request

 # binding.pry
 # iterate over the character hash to find the collection of `films` for the given
 #   `character`
 # collect those film API urls, make a web request to each URL to get the info
 #  for that film
 # return value of this method should be collection of info about each film.
 #  i.e. an array of hashes in which each hash reps a given film
 # this collection will be the argument given to `parse_character_movies`
 #  and that method will do some nice presentation stuff: puts out a list
 #  of movies by title. play around with puts out other info about a given film.



def parse_character_movies(films_hash)
 titles = []
 characters = []
 films_hash.each do |pairs|
   titles << pairs["title"]
   characters << pairs["characters"]
 # some iteration magic and puts out the movies in a nice list
 end


 i = 0
 while i<titles.length
   puts "#{i+1}. Movie Title"
   puts titles[i]
   puts "--------------"
   i+=1
 end

 #titles is an array
 num = character_request(titles.length)
 puts titles[num-1]
 puts "Starring: "
 characters[num-1].each do |char_link|
   data = make_request(char_link)
   puts data["name"]
 end
end


def character_request(number)
 loop do
   puts "See cast? If so type number."
   input = gets.chomp

   if input.to_i <= number && input.to_i>0
     return input.to_i
   else
     puts "invalid input"
   end
 end
end


def show_character_movies(character)
 films_hash = get_character_movies_from_api(character)
 parse_character_movies(films_hash)
end
