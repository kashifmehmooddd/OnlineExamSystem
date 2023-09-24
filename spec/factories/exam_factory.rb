FactoryBot.define do
  factory :exam, class: 'Exam' do
    exam_code { Faker::Code.isbn }
    score { 0 }
    status { 0 }
    start_time { DateTime.now + (1/24r) }
    end_time { DateTime.now + (2/24r) }
    association :teacher, factory: :teacher
    association :subject, factory: :subject


    trait :approved do
      status {'approved'}
    end

    trait :ready do
       status {'ready'}
    end
  end
end
