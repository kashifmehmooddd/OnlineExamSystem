require 'rails_helper'

RSpec.describe Subject, type: :model do

  describe 'validations test' do
    context 'presence attributes validation test' do
      it { should validate_presence_of(:title) }

    end
  end

   describe 'associations test' do
    context 'Subject associations' do
      it {should have_many(:exams).dependent(:destroy)}
    end
  end
end
