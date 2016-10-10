module ApplicationHelper
  def user_identity
    current_user.name? ? current_user.name : current_user.email
  end

  def navbar_active_class(controller)
    css = ""

    css = "active" if controller == params[:controller]
  end
end
