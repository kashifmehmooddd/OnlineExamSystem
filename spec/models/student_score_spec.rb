require 'rails_helper'


RSpec.describe StudentScore, type: :model do

  describe 'validations test' do
    context 'presence attributes validation test' do
      it { should validate_presence_of(:score) }

    end
  end


   describe 'associations test' do
    context 'Question associations' do
      it { should belong_to(:student) }
      it { should belong_to(:exam) }
    end
  end
end
