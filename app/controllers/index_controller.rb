class IndexController < ApplicationController
  def home
    if user_signed_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page]).search(params[:search])
    end
  end

  def terms
  end
  
end
