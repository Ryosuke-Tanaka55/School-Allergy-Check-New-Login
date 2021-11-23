require 'rails_helper'

RSpec.describe "SchoolStudents", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/school_students/index"
      expect(response).to have_http_status(:success)
    end
  end

end
