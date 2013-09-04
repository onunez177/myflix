# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(name: "Futurama", description: "Bite my shiny metal ass!", poster_url: "futurama_large", small_cover_url: "futurama")
Video.create(name: "Video Game Hangover 47", description: "On this week's show, we're talking about video game endings: the ones that got it right and the ones that missed the mark. Also: Mulchers, hand cramps, vagina monsters, generic white men, and the importance of carrying enough arrows. The end is nigh!", 
             poster_url: "vgh47_large", small_cover_url: "vgh47")
Video.create(name: "Family Guy", description: "Seth McFarlane is totally overrated.", poster_url: "family_guy_large", small_cover_url: "family_guy")
Video.create(name: "Video Game Hangover 71", description: "Besides pretty graphics, what do you want from next gen games? On this week's show, we're hoping for evolution beyond 1080p. We've also got awesome new theme music, talk of the Wii U, and reviews of Double Dragon Neon, Darksiders II and Demons' Score.",
             poster_url: "vgh71_large", small_cover_url: "vgh71")

Genre.create(name: "Comedy")
Genre.create(name: "Drama")
Genre.create(name: "Action")

