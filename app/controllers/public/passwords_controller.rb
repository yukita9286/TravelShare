# frozen_string_literal: true

class Public::PasswordsController < Devise::PasswordsController
    before_action :restrict_password_reset_access, only: [:new, :create, :edit, :update]
    before_action :ensure_normal_customer, only: :create
    


  def ensure_normal_customer
    if params[:customer][:email].downcase == 'guest@example.com'
      redirect_to new_customer_session_path, alert: 'ゲストユーザーのパスワード再設定はできません。'
    end
  end
  
  def restrict_password_reset_access
    if current_admin
      # 管理者にはアクセスを許可する場合のロジック
    else
      redirect_to root_path, alert: "パスワードリセットにアクセスする権限がありません。"
    end
  end
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
