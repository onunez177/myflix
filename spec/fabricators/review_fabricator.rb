Fabricator(:review) do
  rating { (1..5).to_a.sample }
  body { Faker::Lorem.words(20) }
end