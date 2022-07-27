class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_relationship, only: :destroy

  def create
    @user = User.find_by id: params[:followed_id]
    if @user
      current_user.follow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t ".follow_fail"
      redirect_to @user
    end
  end

  def destroy
    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def find_relationship
    @user = Relationship.find_by(id: params[:id]).followed
    return if @user

    flash[:danger] = t ".unfollow_fail"
    redirect_to @user
  end
end
