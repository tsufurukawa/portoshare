Fabricator(:project) do
  title { Faker::Company.name }
  subtitle { Faker::Company.catch_phrase }
end