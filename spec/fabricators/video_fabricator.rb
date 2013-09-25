Fabricator(:video) do
  name { Faker::Name.name }
  description { Faker::Lorem.words(5) }
end