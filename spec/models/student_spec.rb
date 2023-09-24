require 'rails_helper'

RSpec.describe Student, type: :model do

  let!(:student) {build(:student)}


  describe 'associations test' do
    context 'Student associations' do
      it { is_expected.to have_many(:student_scores).dependent(:destroy) }
      it { is_expected.to have_many(:exams).dependent(:destroy) }
      it { is_expected.to have_many(:user_answers).dependent(:destroy) }
      it { is_expected.to have_many(:questions).dependent(:destroy) }
    end
  end


  it 'has a valid factory' do
    expect(FactoryBot.build(:student)).to be_valid
  end

  describe 'custom model function test' do
    context 'User type check' do
      it "should have a type admin" do
        expect(student.student?).to eq(true)
      end
    end
  end


end
