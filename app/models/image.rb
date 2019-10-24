class Image < ApplicationRecord
	belongs_to :imageable, polymorphic: true
	has_attached_file :file, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ""
	validates_attachment_content_type :file, content_type: /\Aimage\/.*\z/
	has_many :mcard_codes	


	before_save :set_hashid

	def set_hashid
		if self.imageable_type == "Mcard"
			self.hashid = SecureRandom.urlsafe_base64(10)
			self.file_file_name = "#{self.hashid}.jpg"
		end
	end
end
