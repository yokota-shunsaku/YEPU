class ToppagesController < ApplicationController
  def index
    if logged_in?
      
      if params[:genre]
        @post = params[:genre]
      else
        @post = 'Myタイムライン'
      end
      
      if params[:genre] == '食事' || params[:genre] == '運動' || params[:genre] == '美容'
      #そのジャンルのPost一覧を取得するコード
        @posts = Post.where(genre: params[:genre]).order(id: :desc).page(params[:page]).per(10)
      elsif params[:genre] == 'Allジャンル'
      #全てのPost一覧を取得するコード
        @posts = Post.order(id: :desc).page(params[:page]).per(10)
      else
      #自分とフォローユーザーのPost一覧を取得するコード
        @posts = current_user.feed_posts.order(id: :desc).page(params[:page]).per(10)
      end
      
      if params[:search]
      @posts = Post.all.search(params[:search]).order(id: :desc).page(params[:page]).per(10)
      end
      
    end
  end
end
