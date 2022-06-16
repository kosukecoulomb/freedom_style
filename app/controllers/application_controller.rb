class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when User
      my_page_path
    when AdminUser
      admin_users_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:profile_image, :name, :introduction, :gender, :generation, :tall, :body_shape, :foot_size])
  end
end
