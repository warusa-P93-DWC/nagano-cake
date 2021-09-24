class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def after_sign_in_path_for(resource)
    case resource
     when Admin
      admin_homes_top_path
     when Customer
      root_path(resource)
    end
  end




  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:kana_last_name,:kana_first_name,:email,:telephone_number,:postal_code,:address])
  end
end
