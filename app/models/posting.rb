class Posting < ActiveRecord::Base
	belongs_to :user
	has_many :transactions, dependent: :destroy
	has_many :comments, dependent: :destroy
	validates :title, presence: true
	validates :description, presence: true
	validates :condition, presence: true
	validates :category, presence: true
	validates :address1, presence: true
	geocoded_by :full_address
	after_validation :geocode, if: :address_changed?

	def full_address
		[address1, address2, city, state, zipcode].join(', ')
	end

end
