require 'rails_helper'

RSpec.describe "AlergyChecks", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/alergy_checks/new"
      expect(response).to have_http_status(:success)
    end
  end

end
