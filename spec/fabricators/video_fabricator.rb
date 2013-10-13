Fabricator(:video) do
  name {Faker::Name.name}
  description {Faker::Lorem.characters(20)}
end