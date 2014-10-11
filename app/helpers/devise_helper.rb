module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">x</button>
      #{messages}
    </div>
    HTML

    html.html_safe
  end

  def devise_link_list
    link_list = []
    if controller_name != 'sessions'
      link_list << link_to(t('devise.shared.links.sign_in', default: 'Sign in'), new_session_path(resource_name))
    end
    if devise_mapping.registerable? && controller_name != 'registrations'
      link_list << link_to(t('devise.shared.links.sign_up', default: 'Sign up'), new_registration_path(resource_name))
    end
    if devise_mapping.recoverable? && controller_name == 'sessions'
      link_list << link_to(t('devise.shared.links.forgot_your_password', default: 'Forgot your password?'),
                           new_password_path(resource_name))
    end
    if devise_mapping.confirmable? && ['sessions', 'registrations'].include?(controller_name)
    link_list << link_to(t('devise.shared.links.didn_t_receive_confirmation_instructions',
                             default: 'Didn\'t receive confirmation instructions?'),
                           new_confirmation_path(resource_name))
    end
    if devise_mapping.lockable? && resource_class.unlock_strategy_enabled?(:email) && controller_name != 'unlocks'
      link_list << link_to(t('devise.shared.links.didn_t_receive_unlock_instructions',
                             default: 'Didn\'t receive unlock instructions?'),
                           new_unlock_path(resource_name))
    end
    if devise_mapping.omniauthable?
      resource_class.omniauth_providers.each do |provider|
        link_list << link_to(t('devise.shared.links.sign_in_with_provider', provider: provider.to_s.titleize,
                               default: "Sign in with #{provider.to_s.titleize}"),
                             omniauth_authorize_path(resource_name, provider))
      end
    end
    link_list.map {|link| link.html_safe}
  end

end