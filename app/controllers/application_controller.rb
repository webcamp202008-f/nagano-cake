class ApplicationController < ActionController::Base

before_action :configure_permitted_parameters, if: :devise_controller?



def after_sign_in_path_for(resource)
	  case resource
	  when Admin
	    admin_admin_tops_path
	  when Customer
	    root_path
	  end
end


def after_sign_out_path_for(resource)


  if resource == :admin
    new_admin_session_path
  else
  	new_customer_session_path
  end

end

#byebug


protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :encrypted_password, :family_name, :first_name, :family_name_kana, :first_name_kana, :post_code, :address, :phone_number])
    end
end

