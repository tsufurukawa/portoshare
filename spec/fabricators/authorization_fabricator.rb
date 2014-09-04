Fabricator(:authorization) do
  provider "github"
  uid { Faker::Number.number(7) }
  access_token { Faker::Lorem.characters(20) }
  nickname { Faker::Internet.user_name }
  url { Faker::Internet.url }
end