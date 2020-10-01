class IndexController < ApplicationController
  def home
    if user_signed_in?
      @post  = current_user.posts.build
      @feeds = Post.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc).search(params[:search])
      # @feed_items = current_user.feed.paginate(page: params[:page]).search(params[:search])
    end
  end

  def terms
  end
  
end
