require 'rails_helper'

RSpec.describe PlayBooksController, type: :controller do
    let(:user) { create(:user) }
    before { sign_in user }

    describe 'GET #show' do
        let(:play_book) { create(:play_book) }
        subject { get :show, params: { id: play_book.id }, format: :json }

        describe 'succesfull response' do
            before{ subject }
            it { expect(response).to be_successful } 
            it { expect(response).to render_template('show') }
        end
    end
end
