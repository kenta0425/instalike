class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :following, :followers]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    if @user.posts.any?
      @post = Post.find(params[:id])
      @comment = Comment.new
      @comments = @post.comments.order(created_at: :desc)
      @myfeeds = Post.where(user_id: [@post.id]).order(created_at: :desc)
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash.now[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :username, :email, :website, :profile, :sex)
    end
end
