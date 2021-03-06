class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create desroy]
  before_action :correct_user, only: %i[destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      redirect_to root_url, flash: {success: "Micropost created!"}
    else
      @feed_items = []
      render "staticpages/home"
    end
  end

  def destroy
    @micropost.destroy
    redirect_to request.referrer || root_url, flash: {success: "Micropost deleted"}
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
