class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @post = current_user.posts.build
    end
  end
  
  def show
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'メモを投稿しました'
      redirect_to root_url
    else
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page]).per(30)
      flash.now[:danger] = 'メモの投稿に失敗しました'
      render 'posts/index'
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = 'メモは正常に更新されました'
      redirect_to @post
    else
      flash.now[:danger] = 'メモは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = 'メモを削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:content, :genre, :image)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
