class McardCode < ApplicationRecord
  belongs_to :sender, class_name: "User"#, primary_key: "sender_id"
  belongs_to :reciever, class_name: "User"#, primary_key: "reciever_id"
  belongs_to :mcard
  belongs_to :image
  has_one :medium, dependent: :destroy
  # has_attached_file :image, default_url: ""
  # validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates_uniqueness_of :hashid

  def send_card(sender, email)
    return false if sent?
    self.sender_id = sender.id
    self.sent_at = DateTime.now
    self.email = email
    save
    sent?
  end

  def recieve_card(reciever, email)
    if recieved?
      if self.reciever_id == reciever.id# && self.email == email
        # self.reciever_id = reciever.id
        # self.recieved_at = DateTime.now
        # save
        recieved?
      else
        return false
      end
    # elsif self.email == email
    #   self.reciever_id = reciever.id
    #   self.recieved_at = DateTime.now
    #   # self.email = email
    #   save
    #   recieved? 
    else
      self.reciever_id = reciever.id
      self.recieved_at = DateTime.now
      save
      recieved?
    end
  end


  def send_card_v2(sender, email)
    return false if sent?
    self.sender_id = sender.id
    self.sent_at = DateTime.now
    self.email = email
    save
    sent?
  end

  def recieve_card_v2(reciever, email)
    if recieved?
      if self.reciever_id == reciever.id && self.email == email
        self.reciever_id = reciever.id
        self.recieved_at = DateTime.now
        save
        recieved?
      else
        return false
      end
    elsif self.email == email
      self.reciever_id = reciever.id
      self.recieved_at = DateTime.now
      # self.email = email
      save
      recieved? 
    else
      return false
    end
  end

  # def owner(user)
  # sender_id != user.id && reciever_id != user.id
  # end

  def sent?
    sender_id.present?
  end

  def recieved?
    reciever_id.present?
  end

  def self.customer(id)
    User.find(id)
  end

  def title
    hashid
  end

  def qr_url
    if self.url.nil? || self.url.blank?
      url = "http://giftit.vizidots.com/mcard?mcardcode=#{self.hashid}"
    else
      url = self.url
    end  
  end

  def qr_code
    RQRCode::QRCode.new(qr_url, size: 6, level: :l, mode: :byte_8bit)
  end

  def svg_qr_code
    qr_code.as_svg(module_size: 3).html_safe
  end

  def self.creation_sql(mcard_id, title, balance, url, hashid)
    if hashid.nil?
      hashid = "#{SecureRandom.urlsafe_base64(10)}"
    end
    "INSERT INTO #{self.table_name} (mcard_id, hashid, updated_at, created_at, url) VALUES (#{mcard_id}, '#{hashid}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '#{url}')"
  end

  private

  def set_hashid
    self.hashid = SecureRandom.urlsafe_base64(10)
  end
end
