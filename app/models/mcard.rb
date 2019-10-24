class Mcard < ApplicationRecord
	has_many :mcard_codes, dependent: :destroy
	has_many :images, as: :imageable, dependent: :destroy
	accepts_nested_attributes_for :images, :allow_destroy => true

	has_and_belongs_to_many :sub_admins
end
