class Posting < ActiveRecord::Base
	belongs_to :user
	has_many :transactions
	# has_many :transactions, dependent: :destroy
	has_many :comments, dependent: :destroy
	validates :title, presence: true
	validates :description, presence: true
	validates :condition, presence: true
	validates :category, presence: true
	validates :city, presence: true
	validates :state, presence: true
	validates :zipcode, zipcode: true
	validates :zipcode, zipcode: { country_code: :my }
	validates :zipcode, zipcode: { country_code_attribute: :zipcode }
	geocoded_by :full_address
	after_validation :geocode, if: ->(posting){ self.full_address.present? and self.full_address_changed? }

	mount_uploaders :avatars, AvatarUploader
	skip_callback :commit, :after, :remove_previously_stored_avatars!
	
	def full_address
		[address1, address2, city, state, zipcode].join(', ')
	end

	def full_address_changed?
		attrs = %w{address1 address2 city state zipcode}
		attrs.any?{|a| send "#{a}_changed?"}
	end

	def country_alpha2

	end
end
