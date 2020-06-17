require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  let(:user) { create(:user) }
  before { sign_in user }

  describe 'GET #index' do

    subject { get :index }

    describe 'successful response' do
      before { subject }
      it { expect(response).to be_successful }
      it { expect(response).to render_template('index') }
    end

    context 'events' do

      let!(:event1) { create(:event, user_id: user.id) }
      let!(:event2) { create(:event, user_id: user.id) }

      it 'returns all events' do
        subject
        expect(assigns(:events)).to match_array([event1, event2])
      end
    end
  end

  describe 'GET #edit' do
    let(:event) { create(:event, user_id: user.id) }
    before { get :edit, params: {id: event.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template }
    end

    context 'event' do
      it 'returns one event by given id' do
        expect(assigns(:event)).to eq(event)
      end
    end
  end

  describe 'GET #edit' do
    let(:event) { create(:event, user_id: user.id) }
    before { get :edit, params: {id: event.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template }
    end

    context 'event' do
      it 'returns one event by given id' do
        expect(assigns(:event)).to eq(event)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { event: attributes_for(:event, user_id: user.id) } }
    let(:invalid_attributes) { { event: attributes_for(:event, user_id: user.id, opponent: "") } }

    context 'valid attributes' do
      subject { post :create, params: valid_attributes }
      it { expect(subject).to redirect_to('/events') }
      it { expect { subject }.to change(Event, :count).by(1) }
    end

    context 'invalid attributes' do
      subject { post :create, params: invalid_attributes }
      it { expect(subject).to render_template('new') }
      it { expect { subject }.to_not change(Event, :count) }
    end
  end

  describe 'PUT #update' do
    let(:event) { create(:event, user_id: user.id) }
    let(:valid_attributes) { {id: event.id, event: attributes_for(:event, user_id: user.id) } }
    let(:invalid_attributes) { {id: event.id, event: attributes_for(:event, user_id: user.id, opponent: nil) } }

    context 'valid attributes' do
      subject { put :update, params: valid_attributes }
      it { expect(subject).to redirect_to(events_url) }

      it 'redirect with notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'updates event' do
        subject
        expect(event.reload.opponent).to eq(valid_attributes[:event][:opponent])
      end
    end

    context 'invalid attributes' do
      subject { put :update, params: invalid_attributes }
      it { expect(subject).to render_template(:edit) }
      it { expect { subject }.not_to change(event, :opponent) }
    end
  end

  describe 'DELETE #destroy' do
    let(:event) { create(:event, user_id: user.id) }
    subject{ delete :destroy, params: {id: event.id } }
    it { expect(subject).to redirect_to(events_url) }

    it 'redirect with notice' do
      subject
      expect(flash[:notice]).to be_present
    end

    it 'delete event' do
      event
      expect { subject }.to change(Event, :count).by(-1)
    end
  end

end
