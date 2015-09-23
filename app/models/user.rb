class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
    before_create :create_remember_token
	validates :name, presence:true, length: {maximum: 50}
	 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,
	                  format: { with: VALID_EMAIL_REGEX },
	                  uniqueness: true
    has_secure_password
    validates :password, length: { minimum:6 }

    has_many :tweets, dependent: :destroy
    #フォローしている
    has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
    has_many :followings, through: :following_relationships

    #フォローされている
    has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
    has_many :followers, through: :follower_relationships

    #フォローしているか
    def following?(other_user)
        following_relationships.find_by(following_id: other_user.id)
    end
    #フォローする関数
    def follow!(other_user)
        following_relationships.create!(following_id: other_user.id)
    end
    #フォローを外す関数
    def unfollow!(other_user)
        following_relationships.find_by(following_id: other_user.id).destroy
    end

    def feed
        Tweet.from_users_followed_by(self)
    end



    #だめだったら6.20で

    def set_image(file)
    	if !file.nil?
    		file_name = file.original_filename
    		File.open("public/docs/#{file_name}", 'wb'){|f| f.write(file.read)}
    		self.image = file_name
    	end
    end

    def User.new_remember_token
        SecureRandom.urlsafe_base64
    end

    def User.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

    private

      def create_remember_token
        self.remember_token = User.encrypt(User.new_remember_token)
      end

end
