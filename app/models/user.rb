class User < ActiveRecord::Base
	#before_save { self.email = email.downcase }
	validates :name, presence:true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\W+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,
	                  format: { with: VALID_EMAIL_REGEX },
	                  uniqueness: true
    has_secure_password
    validates :password, length: { minimum:6 }

    has_many :tweets

    def set_image(file)
    	if !file.nil?
    		file_name = file.original_file_name
    		File.open("public/docs/#{file_name}", 'wb'){|f| f.write(file.read)}
    		self.image = file_name
    	end
    end
end
