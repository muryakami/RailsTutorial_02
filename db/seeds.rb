User.create!(name:  "Murakami Yuki",
             email: "y-murakami@nekojarashi.com",
             password:              "neko2474",
             password_confirmation: "neko2474")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@nekojarashi.com"
  password = "neko2474"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end