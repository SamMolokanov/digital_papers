FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "#{n} John Doe" }
    sequence(:email) { |n| "#{n}_joe@gmail.com" }
    password { "foobar123" }
    password_confirmation { "foobar123" }
  end
end
