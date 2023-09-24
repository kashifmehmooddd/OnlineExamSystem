FactoryBot.define do
  factory :subject, class: 'Subject' do
    title { Faker::Name.name }
  end
end
