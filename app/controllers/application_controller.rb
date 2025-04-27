class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |e|
    redirect_to root_path, alert: e.message
  end
end
