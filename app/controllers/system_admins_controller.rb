class SystemAdminsController < ApplicationController
  before_action :authenticate_system_admin!

  def index
  end
end
