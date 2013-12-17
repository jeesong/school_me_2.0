class WelcomeController < ApplicationController
  def index
  end

  def search
    zip = params[:search]
    state = zip.to_region(:state => true)
    area = zip.to_region
    # Other nearby zip
    if area != nil
        @nearby_zip = area.to_zip
        if @nearby_zip.length > 7
            zip_index = @nearby_zip.index(zip)
            if zip_index > 3
                @nearby_zip = @nearby_zip[zip_index-3..zip_index+3]
            else
                @nearby_zip = @nearby_zip[0..5]
            end
        end
        @nearby_zip.delete(zip)
    end

    gon.set_lat = zip.to_lat
    gon.set_long= zip.to_lon
    trulia_url = "http://api.trulia.com/webservices.php?library=TruliaStats&function=getZipCodeStats&zipCode=#{zip}&startDate=2013-12-01&endDate=2013-12-01&apikey=#{ENV["TRULIA_API_KEY"]}"

    trulia_result = Nokogiri::XML(open(trulia_url, :read_timeout => 10))
    @median_listing = trulia_result.xpath("/TruliaWebServices/response/TruliaStats/listingStats/listingStat/listingPrice/subcategory[1]/medianListingPrice").text
    @average_listing = trulia_result.xpath("/TruliaWebServices/response/TruliaStats/listingStats/listingStat/listingPrice/subcategory[1]/averageListingPrice").text

    @name = []
    gon.school_name = []
    @address = []
    gon.school_address = []
    @phone = []
    gon.phone = []
    @rating = []
    @lat = []
    gon.lat = []
    @long = []
    gon.long = []
    @gsid = []
    gon.gsid = []
    @ncesid = []
    gon.ncesid = []
    @state = []
    @school_type = []
    gon.school_type = []
    @grade_range = []
    gon.grade_range = []
    @enrollment = []
    @district = []

    greatschool_url = "http://api.greatschools.org/schools/nearby?key=#{ENV["GREATSCHOOLS_API_KEY"]}&state=#{state}&zip=#{zip}&radius=2"

    begin
        greatschool_result = Nokogiri::XML(open(greatschool_url, :read_timeout => 10))
        for i in 1..100
          if (greatschool_result.xpath("/schools/school[#{i}]").text).empty?
            break
          else
            @name << greatschool_result.xpath("/schools/school[#{i}]/name").text
            gon.school_name << greatschool_result.xpath("/schools/school[#{i}]/name").text
            @address << greatschool_result.xpath("/schools/school[#{i}]/address").text
            gon.school_address << greatschool_result.xpath("/schools/school[#{i}]/address").text
            @phone << greatschool_result.xpath("/schools/school[#{i}]/phone").text
            gon.phone << greatschool_result.xpath("/schools/school[#{i}]/phone").text
            @rating << greatschool_result.xpath("/schools/school[#{i}]/gsRating").text
            @lat << greatschool_result.xpath("/schools/school[#{i}]/lat").text
            gon.lat << greatschool_result.xpath("/schools/school[#{i}]/lat").text
            @long << greatschool_result.xpath("/schools/school[#{i}]/lon").text
            gon.long << greatschool_result.xpath("/schools/school[#{i}]/lon").text
            @gsid << greatschool_result.xpath("/schools/school[#{i}]/gsId").text
            gon.gsid << greatschool_result.xpath("/schools/school[#{i}]/gsId").text
            @state << state
            @school_type << greatschool_result.xpath("/schools/school[#{i}]/type").text
            gon.school_type << greatschool_result.xpath("/schools/school[#{i}]/type").text
            @grade_range << greatschool_result.xpath("/schools/school[#{i}]/gradeRange").text
            gon.grade_range << greatschool_result.xpath("/schools/school[#{i}]/gradeRange").text
            @enrollment << greatschool_result.xpath("/schools/school[#{i}]/enrollment").text
            @district << greatschool_result.xpath("/schools/school[#{i}]/district").text
          end
        end
    rescue OpenURI::HTTPError
        redirect_to root_path
    end

  end
end