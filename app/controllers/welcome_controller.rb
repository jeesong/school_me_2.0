class WelcomeController < ApplicationController
  def index
  end

  def search
    zip = params[:search]
    state = zip.to_region(:state => true)
    gon.set_lat = zip.to_lat
    gon.set_long= zip.to_lon
    trulia_key = "7wb2jef2dwzyre26hf26vt9p"
    trulia_url = "http://api.trulia.com/webservices.php?library=TruliaStats&function=getZipCodeStats&zipCode=#{zip}&startDate=2013-12-01&endDate=2013-12-01&apikey=#{trulia_key}"
    trulia_result = Nokogiri::XML(open(trulia_url))
    @median_listing = trulia_result.xpath("/TruliaWebServices/response/TruliaStats/listingStats/listingStat/listingPrice/subcategory[1]/medianListingPrice").text
    @average_listing = trulia_result.xpath("/TruliaWebServices/response/TruliaStats/listingStats/listingStat/listingPrice/subcategory[1]/averageListingPrice").text

    greatschools_key = "dvfn2l6v3epdlebuzjr5eaxx"
    greatschool_url = "http://api.greatschools.org/schools/nearby?key=#{greatschools_key}&state=#{state}&zip=#{zip}&radius=2"
    greatschool_result = Nokogiri::XML(open(greatschool_url))

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

  end
end