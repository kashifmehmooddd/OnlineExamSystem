require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:question) {build(:question, answer: "5", base: 1)}

  describe 'validations test' do
    context 'presence attributes validation test' do
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:answer) }
      it { should validate_presence_of(:score) }
      it { should validate_presence_of(:base) }
    end
  end

  describe "check answer when type is MCQ" do
    context "Calling the MCQ Answer validation" do
      subject {question.mcq_answer}
      it "is expected to show the error" do
        expect(subject).to eq([" should be in the option numbers"])
      end
    end
  end

  describe 'associations test' do
    context 'Question associations' do
      it { is_expected.to have_many(:user_answers).dependent(:destroy) }
      it { is_expected.to have_many(:students).dependent(:destroy) }
      it { is_expected.to have_many(:options).dependent(:destroy) }
    end
  end
end
