FactoryBot.define do
  factory :student_score, class: 'StudentScore' do
    score { 20 }
    student_id { 0 }
    exam_id_id { 0 }
  end
end
