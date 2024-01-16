class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email])
      if user.present? && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:success] = t('.success')
        redirect_to root_path
      else
        flash[:danger] = t('.danger')
        render :new
      end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = t('.success')
    redirect_to root_path
  end
end
