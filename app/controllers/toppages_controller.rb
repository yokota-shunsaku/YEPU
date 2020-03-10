class ToppagesController < ApplicationController
  def index
    if logged_in?
    
      #binding.pry
      
      
      if params[:genre] == 'eat' || params[:genre] == 'exercise' || params[:genre] == 'beauty'
      #そのジャンルのPost一覧を取得するコード
        @posts = Post.where(genre: params[:genre]).order(id: :desc).page(params[:page]).per(3)
       
      elsif params[:genre] == 'all'
      #全てのPost一覧を取得するコード
        @posts = Post.order(id: :desc).page(params[:page]).per(3)
        
      else
      #自分とフォローユーザーのPost一覧を取得するコード
        @posts = current_user.feed_posts.order(id: :desc).page(params[:page]).per(3)
       
      end
    end
  end
end