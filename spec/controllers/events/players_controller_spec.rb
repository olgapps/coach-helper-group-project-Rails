require 'rails_helper'

RSpec.describe Events::PlayersController, type: :controller do

  let(:user) { create(:user) }
  before { sign_in user }

  describe 'PATCH #assign' do
    let(:player) { create(:player, user_id: user.id) }
    let(:event) { create(:event, user_id: user.id) }
    let(:valid_attributes) { { event_id: event.id, id: player.id } }
    let(:invalid_attributes) { { event_id: event.id, id: player.id } }

    context 'valid attributes' do
      subject { patch :assign, params: valid_attributes }
      it { expect(subject).to redirect_to(events_path) }

      it 'redirect with notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'updates list of players that belongs to event' do
        subject
        expect(event.players.count).to eq(1)
      end
    end

    context 'invalid attributes' do
        subject { patch :assign, params: invalid_attributes }
        it { expect(subject).to redirect_to(events_path) }
  
        before {event.players << player}
        it 'redirect with notice' do
          subject
          expect(flash[:alert]).to be_present
        end
  
        it 'updates list of players that belongs to event' do
          subject
          expect(event.players.count).to_not eq(2)
        end
      end
  end

  describe 'PUT #update' do
    let(:player) { create(:player, user_id: user.id) }
    let(:event) { create(:event, user_id: user.id) }
    let(:event2) { create(:event, user_id: user.id) }
    let(:player2) { create(:player, user_id: user.id, yellow_cards: 3) }
    let(:valid_attributes) { { id: player.id, event_id: event.id, player: attributes_for(:player, yellow_cards: 1) } }
    let(:invalid_attributes) { { id: player.id, event_id: event.id, player: attributes_for(:player, yellow_cards: nil) } }
    let(:set_suspended) { {id: player2.id, event_id: event.id, player: attributes_for(:player, yellow_cards: 1) } }
    let(:dont_set_suspended) { {id: player.id, event_id: event2.id, player: attributes_for(:player, yellow_cards: 1) } }

    context 'valid attributes' do
      subject { put :update, params: valid_attributes, format: :js }
      it { expect(subject).to render_template('events/update_modal') }

      it 'updates player' do
        subject
        expect(player.reload.yellow_cards).to eq(valid_attributes[:player][:yellow_cards])
      end

      context 'invalid attributes' do
        subject { put :update, params: invalid_attributes, format: :js }
        it { expect(subject).to render_template('events/error') } 
        it { expect { subject }.not_to change(player, :yellow_cards) }
      end

      context 'set suspended' do
        subject {put :update, params: set_suspended, format: :js }
        it { expect(subject).to render_template('events/update_modal') }
        it 'set suspended to true and cheange yellow_cards to 0' do
          subject
          expect(player2.reload.suspended).to eq(true)
          expect(player2.reload.yellow_cards).to eq(0)
       end
      end

      context 'dont set suspended' do
        subject {put :update, params: dont_set_suspended, format: :js }
        it { expect(subject).to render_template('events/update_modal') }
        it 'set suspended to false and set yellow_cards to 1' do
          subject
          expect(player.reload.suspended).to eq(false)
          expect(player.reload.yellow_cards).to eq(1)
        end
      end
    end
  end
end
