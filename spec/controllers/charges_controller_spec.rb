
require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

  end

  describe "POST create" do
    it "changes role to premium" do
      expect(user.role).to eq ("premium")
    end
  end

end
