Fabricator(:video) do
  name { Faker::Name.name }
  description { Faker::Lorem.words(5) }
  poster_url { Faker::Name.name }
  small_cover_url { Faker::Name.name }
end