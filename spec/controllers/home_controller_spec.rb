require 'rails_helper'

RSpec.describe HomeController, type: :controller do
    let(:user) { create(:user) }
    before { sign_in user }

    describe 'GET #index' do
        subject { get :index }

        describe 'succesfull response' do
            before{ subject }
            it { expect(response).to be_successful } 
            it { expect(response).to render_template('index') }
        end
    end
end