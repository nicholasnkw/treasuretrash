class User < ActiveRecord::Base
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	has_many :comments, dependent: :destroy
  	has_many :postings, dependent: :destroy
  	has_many :transactions, dependent: :destroy
    has_many :payments

    mount_uploader :avatar, AvatarUploader

  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, :omniauth_providers => [:facebook]

    # attr_accessible :email, :password,  :remember_me, :avatar, :avatar_cache, :remove_avatar

    # validates_presence_of   :avatar
    # validates_integrity_of  :avatar
    # validates_processing_of :avatar

    def self.from_omniauth(auth)
	  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.first_name = auth.info.name   # assuming the user model has a name
      
	    user.facebook_image = auth.info.image # assuming the user model has an image
      # byebug
	  end
	end

	def self.new_with_session(params, session)
	    super.tap do |user|
	      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
	        user.email = data["email"] if user.email.blank?
	      end
	    end
	end

end
