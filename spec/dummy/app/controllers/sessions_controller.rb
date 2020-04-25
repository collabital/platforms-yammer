require_dependency "application_controller"

class SessionsController < ApplicationController
  include Platforms::Yammer::Authentication

  before_action :set_token

  def create
    save_identity
  end

  def destroy
  end

end
