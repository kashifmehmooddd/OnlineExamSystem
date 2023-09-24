FactoryBot.define do
  factory :option, class: 'Option' do
    description { Faker.lorem.sentence(1) }
    question_id { 0 }
  end
end
