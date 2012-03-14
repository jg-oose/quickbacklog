class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def project_from_session
    Project.first
  end
end
