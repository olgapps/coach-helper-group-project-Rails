require 'rails_helper'

RSpec.describe Event, type: :model do
    describe 'attributes' do
        it 'should have proper attributes' do
            expect(subject.attributes).to include('opponent', 'event_date','user_id', 'event_type', 'created_at', 'updated_at')
        end
    end

    describe 'validations' do
        it { is_expected.to validate_presence_of(:opponent) }
        it { is_expected.to validate_presence_of(:event_date) }
    end

    describe 'relations' do
        it { is_expected.to belong_to(:user) } 
    end
end
