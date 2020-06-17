require 'rails_helper'

RSpec.describe Api::V1::PlayersController, type: :controller do

  let(:user) { create(:user) }
  let!(:player) { create(:player, user_id: user.id, name: "Kamil", number: 32, surname: "Kamil") }
  before { sign_in user }
  
  render_views
  describe 'GET #index' do
    before { get :index, format: :json }
   
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end