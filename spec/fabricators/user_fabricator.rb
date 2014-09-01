Fabricator(:user) do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  password { Faker::Internet.password(8) }
  username { Faker::Internet.user_name }
  location { Faker::Address.city }
  bio { Faker::Lorem.sentences(2).join(' ') }
end