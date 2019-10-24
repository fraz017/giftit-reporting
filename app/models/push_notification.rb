class PushNotification < ApplicationRecord
  belongs_to :user
	validates_presence_of :device_token

	before_save :check_token
	after_save :set_user_platforms

	def check_token
		PushNotification.where(device_token: self.device_token).delete_all
		# PushNotification.where(user_id: self.user_id).delete_all
	end
	
	def set_user_platforms
		platforms = user.push_notifications.collect(&:platform).uniq
		if platforms.count == 2
			user.platform = 'ios & android'
		else
			user.platform = platforms.first
		end
		user.save
	end
end
