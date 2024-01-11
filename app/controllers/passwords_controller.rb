class PasswordsController < ApplicationController
  before_action :user_login_required

  def edit

  end

  def update
      if Current.user.update(password_params)
          flash[:success] = "パスワールドを更新しました。もう一度ログインしてください。"
          session[:user_id] = nil
          redirect_to login_path
      else
          flash[:danger] = "パスワードの更新が失敗しました。もう一度試してください。"
          render :edit, status: :unprocessable_entity
      end


  end

  private

  def password_params
      params.require(:user).permit(:password, :password_confirmation)
  end
end
