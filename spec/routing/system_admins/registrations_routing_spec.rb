require 'rails_helper'

RSpec.describe SystemAdmins::RegistrationsController, type: :routing do
  describe 'システム管理者のルートが存在していないこと' do
    it 'routes to #new' do
      expect(get: '/system_admins/sign_up').not_to be_routable
    end
    it 'routes to #create' do
      expect(post: '/system_admins').not_to be_routable
    end
    it 'routes to #edit' do
      expect(get: '/system_admins/edit').not_to be_routable
    end
    it 'routes to #update' do
      expect(put: '/system_admins').not_to be_routable
    end
    it 'routes to #destroy' do
      expect(delete: '/system_admins').not_to be_routable
    end
    it 'routes to #cancel' do
      expect(get: '/system_admins/cancel').not_to be_routable
    end
  end
end