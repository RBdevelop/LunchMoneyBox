require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe "GET #overview" do
    it "returns http success" do
      get :overview
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #activity" do
    it "returns http success" do
      get :activity
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #credits" do
    it "returns http success" do
      get :credits
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #debits" do
    it "returns http success" do
      get :debits
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #reports" do
    it "returns http success" do
      get :reports
      expect(response).to have_http_status(:success)
    end
  end

end
