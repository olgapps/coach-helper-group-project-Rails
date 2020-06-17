require 'rails_helper'

RSpec.describe Events::PlayBooksController, type: :controller do

  let(:user) { create(:user) }
  before { sign_in user }

  describe 'PUT #update' do
    let(:play_book) { create(:play_book) }
    let(:event) { create(:event, user_id: user.id) }
    let(:event2) { create(:event, user_id: user.id) }
    let(:valid_attributes) { { event_id: event.id, id: play_book.id } }
    let(:invalid_attributes) { { event_id: event.id, id: play_book.id, play_book: attributes_for(:play_book, name: nil) } }

    context 'valid attributes' do
      subject { put :update, params: valid_attributes }
      it { expect(subject).to redirect_to(events_path) }

      it 'redirect with notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'updates list of play books that belongs to event' do
        subject
        expect(event.play_books.count).to eq(1)
      end
    end

    context 'invalid attributes' do
      subject { put :update, params: invalid_attributes }
      it { expect(subject).to redirect_to(events_path) }

      before {event.play_books << play_book}
      it 'redirect with notice' do
        subject
        expect(flash[:alert]).to be_present
      end

      it 'updates list of play books that belongs to event' do
        subject
        expect(event.play_books.count).to eq(1)
      end
    end
  end
end
