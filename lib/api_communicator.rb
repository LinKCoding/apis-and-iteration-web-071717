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

  #hash solution
  # ordered_films = {}
  # films.each_with_index do |e, index|
  #   this_site = RestClient.get(e)
  #   parsed_site = JSON.parse(this_site)
  #   ordered_films[index + 1] = parsed_site["title"]
  # end
  #
  # ordered_films

  ordered_films = films.map do |film|
    this_site = RestClient.get(film)
    parsed_site = JSON.parse(this_site)
    parsed_site["title"]
  end
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  #this is for a hash
  # films_hash.each do |number, film|
  #   puts "#{number} #{film}"
  # end
  films_hash.each_with_index do |film, index|
    puts "#{index +1} #{film}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
