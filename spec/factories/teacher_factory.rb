FactoryBot.define do
  factory :teacher, class: 'Teacher' do
    full_name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }

    after(:build) do |teacher|
      teacher.confirm
    end

  end
end
