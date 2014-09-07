Fabricator(:project_detail) do
  header { Faker::Company.catch_phrase }
  content { Faker::Lorem.sentences(3).join(' ') }
end