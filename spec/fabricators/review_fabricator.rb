Fabricator(:review) do
  rating { (1..5).to_a.sample }
  body { Faker::Lorem.characters(20) }
end