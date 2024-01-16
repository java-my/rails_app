class SignupController < ApplicationController
  def new
    @user = User.new
    pp @user
    @gender_options = User.genders_i18n.invert.map{|key,value|[key,value]}
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "アカウトを作成しました。"
      redirect_to root_path
    else
        render :new
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :gender, :password, :password_confirmation)
  end
end
