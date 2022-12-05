# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    basic_action
  end

  private

  def basic_action
    @omniauth = request.env['omniauth.auth']
    is_signup = false
    return if @omniauth.blank?

    @profile = User.find_or_initialize_by(provider: @omniauth['provider'], uid: @omniauth['uid'])
    if @profile.email.blank?
      email = @omniauth['info']['email'] || "#{@omniauth['uid']}-#{@omniauth['provider']}@example.com"
      @profile = current_user || User.create!(provider: @omniauth['provider'], uid: @omniauth['uid'],
                                              email:, name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
      is_signup = true
    end
    @profile.auth_values(@omniauth)
    sign_in(:user, @profile)
    if is_signup == true
      flash[:notice] = 'サインアップしました'
      redirect_to edit_user_registration_path
    else
      flash[:notice] = 'ログインしました'
      redirect_to root_path
    end
  end

  def fake_email(uid, provider)
    "#{uid}-#{provider}@example.com"
  end
end
