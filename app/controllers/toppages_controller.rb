class ToppagesController < ApplicationController
  def index
    #if logged_in?
    
    #binding.pry
    if params[:genre]
    #そのジャンルのPost一覧を取得するコード
      @posts = Post.where(genre: params[:genre]).order(id: :desc).page(params[:page]).per(3)
    else
    #全てのPost一覧を取得するコード
      @posts = current_user.posts.order(id: :desc).page(params[:page]).per(3)
    end
    
    
    #end
  end
  
  
  
  
  #def genres
    #@posts = Post.where(genre_id: @genre_id)
  #end
end