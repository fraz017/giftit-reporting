class Store < ApplicationRecord
	validates_presence_of :name, :latitude, :longitude, :radius
  validates_uniqueness_of :latitude, :longitude
end
