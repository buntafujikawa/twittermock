class Tweet < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC')}
	validates :content, presence: true,length: { maximum: 140 }
	validates :user_id, presence: true

	has_many :fovorites
	has_many :favoriting_users, through: :favorites, source: :user

	def self.from_users_followed_by(user)
      following_ids = user.following_ids
      where("user_id IN (?) OR user_id = ?", following_ids, user)
    end
end
