FactoryBot.define do
  factory :student, class: 'Student' do
    full_name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    after(:build) do |student|
      student.confirm
    end
  end
end
