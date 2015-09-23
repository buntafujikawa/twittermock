class Tweet < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC')}
	validates :content, length: { maximum: 140 }

	def self.from_users_followed_by(user)
      following_ids = user.following_ids
      where("user_id IN (?) OR user_id = ?", following_ids, user)
    end
end
