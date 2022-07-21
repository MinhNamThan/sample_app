class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :find_micropost, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = t ".success"
      redirect_to root_url
    else
      flash.now[:danger] = t ".false_microposts"
      @pagy, @feed_items = pagy current_user.feed.newest
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".delete"
    else
      flash[:danger] = t ".false_delete"
    end
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def find_micropost
    @micropost = current_user.microposts.find_by(id: params[:id])
    return if @micropost

    flash[:danger] = t ".not_found"
    redirect_to root_url
  end
end
