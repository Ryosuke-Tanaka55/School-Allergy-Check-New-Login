require 'rails_helper'

RSpec.describe SystemAdmins::PasswordsController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/system_admins/password/new').to route_to('devise/passwords#new')
    end
    it 'routes to #new' do
      expect(post: '/system_admins/password').to route_to('devise/passwords#create')
    end
    it 'routes to #edit' do
      expect(get: '/system_admins/password/edit').to route_to('devise/passwords#edit')
    end
    it 'routes to #update' do
      expect(put: '/system_admins/password').to route_to('devise/passwords#update')
    end
  end
end