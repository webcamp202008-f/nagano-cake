class ApplicationController < ActionController::Base



def after_sign_in_path_for(resource)
  case resource
  when Admin
    admin_items_path
  when Customers
    new_customer_registration_path
  end
end




protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :encrypted_password, :family_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number])
    end
end
