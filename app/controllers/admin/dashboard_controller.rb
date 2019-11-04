class Admin::DashboardController < AdminController
  # load_and_authorize_resource :mcard
  
  def index
    @mcard = Mcard.find params[:id]
    authorize!(:read, @mcard)
      @day = []
      @daydata = []

      @week = []
      @weekdata = []
      
      @month = []
      @monthdata = []
      
      @today = []
      
      @lastweek = []
      
      @lastmonth = []
      
      @tm =[]
      @wm = []
      @mm = []


      views = @mcard.mcard_codes.group_by_hour(:recieved_at, range: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, time_zone: Time.zone.name, format: "%-l %p").count
      @today = @mcard.mcard_codes.where(recieved_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
      @tm = @today.map{|x| {lat: x.lat, lng: x.lng} if (x.lat.present? && x.lat != 0)}.compact
      @todayS = @mcard.mcard_codes.where("recieved_at IS ?", nil).where(sent_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
      @day = views.keys
      @daydata = views.values
      
      views = @mcard.mcard_codes.group_by_day(:recieved_at, range: 1.week.ago..Time.zone.now, time_zone: Time.zone.name, format: "%a").count
      
      @lastweek = @mcard.mcard_codes.where("recieved_at IS NOT ?", nil).where(recieved_at: 1.week.ago..Time.zone.now)
      @wm = @lastweek.map{|x| {lat: x.lat, lng: x.lng} if (x.lat.present? && x.lat != 0)}.compact
      @lastweekS = @mcard.mcard_codes.where("recieved_at IS ?", nil).where(sent_at: 1.week.ago..Time.zone.now)
      @week = views.keys
      @weekdata = views.values
      
      
      views = @mcard.mcard_codes.group_by_day(:recieved_at, range: 1.month.ago..Time.zone.now, time_zone: Time.zone.name, format: "%d %b").count
      @month = views.keys
      @monthdata = views.values


      @lastmonth = @mcard.mcard_codes.where(recieved_at: 1.month.ago..Time.zone.now)
      @mm = @lastmonth.map{|x| {lat: x.lat, lng: x.lng} if (x.lat.present? && x.lat != 0)}.compact
      @lastmonthS = @mcard.mcard_codes.where("recieved_at IS ?", nil).where(sent_at: 1.month.ago..Time.zone.now)
      @lastSixMonth = @mcard.mcard_codes.where(created_at: 6.month.ago..Time.zone.now).count
      @lastSixMonthR = @mcard.mcard_codes.where("recieved_at IS NOT ?", nil).where(recieved_at: 6.month.ago..Time.zone.now).count
      @lastSixMonthS = @mcard.mcard_codes.where(sent_at: 6.month.ago..Time.zone.now).count
      
      views = @mcard.mcard_codes.group_by_month(:sent_at, range: 6.month.ago..Time.zone.now, time_zone: Time.zone.name, format: "%b").count
      @slsmlabels = views.keys
      @slsmdata = views.values

      views = @mcard.mcard_codes.where("recieved_at IS NOT ?", nil).group_by_month(:recieved_at, range: 6.month.ago..Time.zone.now, time_zone: Time.zone.name, format: "%b").count
      @rlsmlabels = views.keys
      @rlsmdata = views.values

      views = @mcard.mcard_codes.group_by_month(:created_at, range: 6.month.ago..Time.zone.now, time_zone: Time.zone.name, format: "%b").count
      @lsmlabels = views.keys
      @lsmdata = views.values  
      
      

  end

  # def destroy_data
  #   TrackView.destroy_all
  #   redirect_to admin_contents_path, alert: "Data has been reset"
  # end
end
