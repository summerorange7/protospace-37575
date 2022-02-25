class ApplicationController < ActionController::Base
  #before_〜.permitまで：deviseに自作のカラムも併せて操作させたい時に入れる一連の記述
  #devise_controller：deviseをインストールしたときに自動生成される、こちらではいじれない
  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :authenticate_user!
  
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
  end
end
