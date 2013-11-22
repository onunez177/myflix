# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

v1 = Video.create(name: "Futurama", 
             description: "Will Hedonism bot ever find true love? Will Bender finally kill all humans? Tune in to find out!", 
             poster_url: File.open("public/uploads/futurama_large.jpg"), 
             small_cover_url: File.open("public/uploads/futurama.jpg"),
             video_url: "https://s3-us-west-2.amazonaws.com/paul-myflix/movies/FuturamaClip.mp4")
v2 = Video.create(name: "Family Guy", 
             description: "Seth McFarlane is totally overrated.", 
             poster_url: File.open("public/uploads/family_guy_large.jpg"), 
             small_cover_url: File.open("public/uploads/family_guy.jpg"),
             video_url: "https://s3-us-west-2.amazonaws.com/paul-myflix/movies/FamilyGuyClip.mp4")

v3 = Video.create(name: "Video Game Hangover #47", 
             description: "On this week's show, we're talking about video game endings: the ones that got it right and the ones that missed the mark. Also: Mulchers, hand cramps, vagina monsters, generic white men, and the importance of carrying enough arrows. The end is nigh!",
             poster_url: File.open("public/uploads/vgh47_large.jpg"), 
             small_cover_url: File.open("public/uploads/vgh47.jpg"),
             video_url: "https://s3-us-west-2.amazonaws.com/paul-myflix/movies/VGH47Clip.mp4")
v4 = Video.create(name: "Video Game Hangover #71", 
             description: "Besides pretty graphics, what do you want from next gen games? On this week's show, we're hoping for evolution beyond 1080p. We've also got awesome new theme music, talk of the Wii U, and reviews of Double Dragon Neon, Darksiders II and Demons' Score.",
             poster_url: File.open("public/uploads/vgh71_large.jpg"), 
             small_cover_url: File.open("public/uploads/vgh71.jpg"),
             video_url: "https://s3-us-west-2.amazonaws.com/paul-myflix/movies/VGH71Clip.mp4")

v5 = Video.create(name: "Mass Effect 3", 
             description: "The final chapter in the Mass Effect Saga.", 
             poster_url: File.open("public/uploads/masseffect_large.jpg"), 
             small_cover_url: File.open("public/uploads/masseffect_small.jpg"),
             video_url: "https://s3-us-west-2.amazonaws.com/paul-myflix/movies/MassEffect3Clip.mp4")
v6 = Video.create(name: "Transformers: The Movie", 
             description: "Autobots vs Decepticons! The greatest combination of 80s robot action, ever!", 
             poster_url: File.open("public/uploads/transformers_large.jpg"), 
             small_cover_url: File.open("public/uploads/transformers_small.jpg"),
             video_url: "https://s3-us-west-2.amazonaws.com/paul-myflix/movies/TransformersClip.mp4")
v7 = Video.create(name: "Breaking Bad", 
             description: "The greatest show ever made.", 
             poster_url: File.open("public/uploads/breaking_bad_large.jpg"), 
             small_cover_url: File.open("public/uploads/breaking_bad_small.jpg"),
             video_url: "https://s3-us-west-2.amazonaws.com/paul-myflix/movies/BreakingBadClip.mp4")
v8 = Video.create(name: "Batman: Mask of the Phantasm", 
             description: "Best Batman movie ever made.", 
             poster_url: File.open("public/uploads/batman_large.jpg"), 
             small_cover_url: File.open("public/uploads/batman_small.jpg"),
             video_url: "https://s3-us-west-2.amazonaws.com/paul-myflix/movies/BatmanClip.mp4")

top = Genre.create(name: "Top Picks")
comedy = Genre.create(name: "Comedy")
animated = Genre.create(name: "Animated Favourites")
games = Genre.create(name: "Video Games")
vgh = Genre.create(name: "Video Game Hangover")
Genre.create(name: "British Superiority")
Genre.create(name: "Muscle Madness")

v1.genres << comedy
v2.genres << comedy
v3.genres << vgh
v4.genres << vgh
v5.genres << games 
v6.genres << animated
v7.genres << top
v8.genres << animated

u1 = User.create(full_name: "Paul Sandhu", email: "spaulsandhu@gmail.com", password: "password", admin: true)
u2 = User.create(full_name: "Simon Sandhu", email: "simon@test.com", password: "password")
u3 = User.create(full_name: "Bomba Sandhu", email: "bomba@test.com", password: "password")
u4 = User.create(full_name: "Luna Sandhu", email: "luna@test.com", password: "password")

Review.create(body: "I really like this movie, it's incredible!", rating: 5, creator: u1, video: v8)
Review.create(body: "This is the greatest show ever made. Top notch storytelling, acting, you name it!", rating: 5, creator: u1, video: v7)
Review.create(body: "Seth McFarlane can be funny sometimes... but usually not.", rating: 2, creator: u1, video: v2)

Review.create(body: "I'm a cat, so my opinion shouldn't matter much.", rating: 2, creator: u2, video: v4)
Review.create(body: "Meow meow, I like this movie a lot!", rating: 4, creator: u2, video: v6)
Review.create(body: "Once upon a time, a cat wrote a review. This is that time.", rating: 1, creator: u2, video: v1)

Review.create(body: "I have sophisticated taste therefore I like this a lot.", rating: 5, creator: u3, video: v5)
Review.create(body: "Hmm, not so good... no.", rating: 2, creator: u3, video: v3)

Review.create(body: "I am very sweet! Also this movie rocks my socks!", rating: 4, creator: u4, video: v8)
Review.create(body: "Yes.", rating: 1, creator: u4, video: v1)