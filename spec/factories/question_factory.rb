FactoryBot.define do
  factory :question, class: 'Question' do
    description { Faker::Lorem.sentence(2) }
    answer { Faker::Lorem.sentence(1) }
    score { 0 }
    base { 0 }
    association :exam, factory: :exam
  end
end
