require 'rails_helper'

RSpec.describe SystemAdmins::SessionsController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/system_admins/sign_in').to route_to('system_admins/sessions#new')
    end
    it 'routes to #create' do
      expect(post: '/system_admins/sign_in').to route_to('system_admins/sessions#create')
    end
    it 'routes to #destroy' do
      expect(delete: '/system_admins/sign_out').to route_to('system_admins/sessions#destroy')
    end
  end
end