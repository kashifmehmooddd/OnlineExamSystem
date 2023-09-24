require 'rails_helper'

RSpec.describe Teacher, type: :model do
 let(:teacher) {create(:teacher)}
  describe 'custom model function test' do
    context 'User type check' do
      it "should have a type admin" do
        expect(teacher.teacher?).to eq(true)
      end
    end
  end

end
