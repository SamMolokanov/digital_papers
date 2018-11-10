FactoryBot.define do
  factory :document do
    sequence(:name) { |n| "Salary record #{n}" }
    user
  end
end
