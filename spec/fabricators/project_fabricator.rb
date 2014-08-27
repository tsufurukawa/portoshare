Fabricator(:project) do
  title { Faker::Company.name }
  subtitle { Faker::Company.catch_phrase }
  main_description { Faker::Lorem.sentences(10).join(' ')}
end