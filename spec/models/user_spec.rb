require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'attributes' do
        it 'should have proper attributes' do
            expect(subject.attributes).to include('email',
            'encrypted_password', 'reset_password_token', 'remember_created_at', 'reset_password_sent_at', 'created_at', 'updated_at', 'team')
        end
    end

    describe 'validations' do 
        it { is_expected.to validate_presence_of(:email) }
    end

    describe 'relations' do
        it { is_expected.to have_many(:players) }
        it { is_expected.to have_many(:events) }
    end
end