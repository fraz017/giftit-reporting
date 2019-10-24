class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }
  attr_accessor :login

  has_many :sent_cards, class_name: "McardCode", foreign_key: "sender_id"
  has_many :received_cards, class_name: "McardCode", foreign_key: "reciever_id"

  has_many :push_notifications, dependent: :destroy
  has_one :medium, dependent: :destroy

  def ios_token
    self.push_notifications.where(platform: 'ios').last
  end

  def android_token
    self.push_notifications.where(platform: 'android').last
  end
end
