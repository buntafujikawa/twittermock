class AddRetweetToToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :retweet_to, :integer
  end
end
