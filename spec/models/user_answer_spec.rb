require 'rails_helper'

RSpec.describe UserAnswer, type: :model do

  describe 'validations test' do
    context 'presence attributes validation test' do
      it { should validate_presence_of(:answers) }
    end
  end

   describe 'associations test' do
    context 'Question associations' do
      it { should belong_to(:question) }
      it { should belong_to(:student) }
    end
  end
end
