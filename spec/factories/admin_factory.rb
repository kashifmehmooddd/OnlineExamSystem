FactoryBot.define do
  factory :admin, class: 'Admin' do
    full_name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
     after(:build) do |admin|
      admin.confirm
    end
  end
end
