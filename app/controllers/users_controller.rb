class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @tweets = @user.tweets
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    file = params[:user][:image]
    @user.set_image(file)
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to Twitter!"
        redirect_to @user
      else
        render 'new'
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    file = params[:user][:image]
    @user.set_image(file)
      if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followings
     render 'show_follow'
  end

  def followers
     @title = "Followers"
     @user = User.find(params[:id])
     @users = @user.followers
      render 'show_follow'
  end

  def favorite
    @title = 'Favorite Tweets'
    @tweet = current_user.tweets.build
    @feed_tweets = current_user.favorite_tweets
    render template: 'about/index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before actions

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in." unless signed_in?
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
end
