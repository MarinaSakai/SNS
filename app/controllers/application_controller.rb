# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
  end

  def after_sign_in_path_for(_resource)
    posts_path # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(_resource)
    "/" # ログアウト後に遷移するpathを設定(仮)
  end
end
