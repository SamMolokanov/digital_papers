# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(
  name: "Semjon",
  email: "foo@bar.com",
  password: "asdfg12345",
  password_confirmation: "asdfg12345",
)

10000.times do |n|
  user = User.create!(
    name: "UserName#{n}",
    email: "foo#{n}@bar.com",
    password: "#{n}_asdfg12345",
    password_confirmation: "#{n}_asdfg12345",
  )

  user.sessions << Auth::Session.new(pepper: user.password_digest)
  user.save!
end
