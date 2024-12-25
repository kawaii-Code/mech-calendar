class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_locale

  def switch_lang
    cookies[:lang] = params[:lang]
    redirect_to request.referer || root_path
  end

  def clear_lang
    cookies.delete(:lang)
    redirect_to request.referer || root_path
  end

  private

  def set_locale
    I18n.locale = cookies[:lang] || params[:lang] || I18n.default_locale
  end
end
