FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "#{n} John Doe" }
    sequence(:email) { |n| "#{n}_joe@gmail.com" }
    password { "foobar123" }
    password_confirmation { "foobar123" }

    factory :authorized_user do
      after(:create) do |user|
        user.sessions << Auth::Session.new(token: Auth::TokenProvider.new(user.password_digest).generate)
        user.save
      end
    end
  end
end
