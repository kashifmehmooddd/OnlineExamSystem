require 'rails_helper'

RSpec.describe Admin, type: :model do
  let!(:admin) {create(:admin)}

  describe 'validations test' do
    context 'email presence tests' do
      it { should validate_presence_of(:full_name) }
    end
    context 'password presence tests' do
      it { should validate_presence_of(:email) }
    end
  end



  describe 'custom model function test' do
    context 'User type check' do
      it "should have a type admin" do
        expect(admin.admin?).to eq(true)
      end
    end
  end

end


