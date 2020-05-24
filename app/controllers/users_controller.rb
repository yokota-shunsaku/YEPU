class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :likes, :edit, :update]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
    @search_users = User.all.page(params[:page]).search(params[:search])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'プロフィールは正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールは更新されませんでした'
      render :edit
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザーを登録しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました'
      render :new
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.order(id: :desc).page(params[:page])
    counts(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile)
  end
end
