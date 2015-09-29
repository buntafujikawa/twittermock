class SearchController < ApplicationController
  def index
  	@search_word = params[:word]
    @users = User.where(['name LIKE ?', "%#{@search_word}%"])
    @tweets = Tweet.where(['content LIKE ?', "%#{@search_word}%"])
  end
end
