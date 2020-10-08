class ApplicationController < ActionController::Base

before_action :configure_permitted_parameters, if: :devise_controller?



def after_sign_in_path_for(resource)
  case resource
  when Admin
    admin_items_path
  when Customer
    items_path
  end
end




protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :encrypted_password, :family_name, :first_name, :family_name_kana, :first_name_kana, :post_code, :address, :phone_number])
    end
end
