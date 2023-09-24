require 'rails_helper'

RSpec.describe Exam, type: :model do
 describe 'validations test' do
    context 'presence attributes validation test' do
      it { should validate_presence_of(:exam_code) }
      it { should validate_presence_of(:subject_id) }
      it { should validate_presence_of(:start_time) }
      it { should validate_presence_of(:end_time) }
    end
  end

  describe 'associations test' do
    context 'Exam associations' do
      it { is_expected.to have_many(:questions).dependent(:destroy) }
      it { is_expected.to have_many(:student_scores).dependent(:destroy) }
      it { is_expected.to have_many(:students).dependent(:destroy) }
      it { is_expected.to have_many(:questions).dependent(:destroy) }
    end
  end

end
