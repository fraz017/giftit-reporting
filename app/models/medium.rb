class Medium < ApplicationRecord
#   belongs_to :user
#   belongs_to :mcard_code

#   validates :mcard_code_id, :user_id, :presence => true

#  has_attached_file :video#, styles: {
#  #        :medium => {
#  #          :geometry => "640x480",
#  #          :format => 'mp4'
#  #        },
#  #        :thumb => { :geometry => "640x480", :format => 'jpeg', :time => 10}
#  #    }, :processors => [:transcoder]                            
#   validates_attachment_content_type :video, :content_type => ['video/quicktime', 'video/mp4', 'video/mpeg', 'video/mpeg4', 'audio/mp4a-latm', 'audio/mp4']
#   # process_in_background :video

#   attr_accessor :mcardcode

#   before_create :delete_previous

#   def delete_previous

#     Medium.where(mcard_code_id: mcard_code.id).destroy_all
#   end
end
