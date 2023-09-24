FactoryBot.define do
  factory :user_answer, class: 'UserAnswer' do
    answers { Faker::Lorem.sentence(1) }
    status { true }
    student_id { 0 }
    question_id { 0 }
  end
end
