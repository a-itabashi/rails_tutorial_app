class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      # UserMailer.account_activation(@user).deliver_now
      redirect_to root_path, flash: {info: "Please check your email to activate your account."}
    else
      render "new"   
    end
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, flash: {success: "Profile updated"}
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, flash: {success: "User deleted"}

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

end
