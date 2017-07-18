require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  results = character_hash["results"].select do |info|
    info["name"].downcase == character
  end

  films = results[0]["films"]

  # final_films = Hash[films.each_with_index.map do |e, index|
  #    this_site = RestClient.get(e)
  #    parsed_site = JSON.parse(this_site)
  #    final_films[index + 1] = parsed_site["title"]end]

  ordered_films = {}
  films.each_with_index do |e, index|
    this_site = RestClient.get(e)
    parsed_site = JSON.parse(this_site)
    ordered_films[index + 1] = parsed_site["title"]
  end


  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  ordered_films
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |number, film|
    puts "#{number} #{film}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
