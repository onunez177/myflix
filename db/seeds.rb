# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(name: "Futurama", 
             description: "Will Hedonism bot ever find true love? Tune in to find out!", 
             poster_url: File.open("public/uploads/futurama_large.jpg"), 
             small_cover_url: File.open("public/uploads/futurama.jpg"))
Video.create(name: "Video Game Hangover #47", 
             description: "On this week's show, we're talking about video game endings: the ones that got it right and the ones that missed the mark. Also: Mulchers, hand cramps, vagina monsters, generic white men, and the importance of carrying enough arrows. The end is nigh!",
             poster_url: File.open("public/uploads/vgh47_large.jpg"), 
             small_cover_url: File.open("public/uploads/vgh47.jpg"))
Video.create(name: "Family Guy", 
             description: "Seth McFarlane is totally overrated.", 
             poster_url: File.open("public/uploads/family_guy_large.jpg"), 
             small_cover_url: File.open("public/uploads/family_guy.jpg"))
Video.create(name: "Video Game Hangover #71", 
             description: "Besides pretty graphics, what do you want from next gen games? On this week's show, we're hoping for evolution beyond 1080p. We've also got awesome new theme music, talk of the Wii U, and reviews of Double Dragon Neon, Darksiders II and Demons' Score.",
             poster_url: File.open("public/uploads/vgh71_large.jpg"), 
             small_cover_url: File.open("public/uploads/vgh71.jpg"))

Video.create(name: "Mass Effect 3", 
             description: "The final chapter in the Mass Effect Saga.", 
             poster_url: File.open("public/uploads/masseffect_large.jpg"), 
             small_cover_url: File.open("public/uploads/masseffect_small.jpg"))
Video.create(name: "Transformers: The Movie", 
             description: "Autobots vs Decepticons! The greatest combination of 80s robot action, ever!", 
             poster_url: File.open("public/uploads/transformers_large.jpg"), 
             small_cover_url: File.open("public/uploads/transformers_small.jpg"))
Video.create(name: "Breaking Bad", 
             description: "The greatest show ever made.", 
             poster_url: File.open("public/uploads/breaking_bad_large.jpg"), 
             small_cover_url: File.open("public/uploads/breaking_bad_small.jpg"))
Video.create(name: "Batman: Mask of the Phantasm", 
             description: "Best Batman movie ever made.", 
             poster_url: File.open("public/uploads/batman_large.jpg"), 
             small_cover_url: File.open("public/uploads/batman_small.jpg"))

comedy = Genre.create(name: "Comedy")
drama = Genre.create(name: "Drama")
action = Genre.create(name: "Action")

for counter in (1..4) 
  Video.find(counter).genres << comedy
end

for counter in (3..6)
  Video.find(counter).genres << drama
end

for counter in (5..8)
  Video.find(counter).genres << action
end

User.create(full_name: "Paul Sandhu", email: "spaulsandhu@gmail.com", password: "password", admin: true)
User.create(full_name: "Simon Sandhu", email: "simon@test.com", password: "password")
User.create(full_name: "Bomba Sandhu", email: "bomba@test.com", password: "password")
User.create(full_name: "Luna Sandhu", email: "luna@test.com", password: "password")
