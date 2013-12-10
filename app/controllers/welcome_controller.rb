class WelcomeController < ApplicationController
  def index
  end

  def search
    zip = params[:search]
    state = params[:state]
    # real_estate_prices
    trulia_key = "7wb2jef2dwzyre26hf26vt9p"
    trulia_url = "http://api.trulia.com/webservices.php?library=TruliaStats&function=getZipCodeStats&zipCode=#{zip}&startDate=2013-12-01&endDate=2013-12-01&apikey=#{trulia_key}"
    trulia_result = Nokogiri::XML(open(trulia_url))
    @median_listing = trulia_result.xpath("/TruliaWebServices/response/TruliaStats/listingStats/listingStat/listingPrice/subcategory[1]/medianListingPrice").text
    @average_listing = trulia_result.xpath("/TruliaWebServices/response/TruliaStats/listingStats/listingStat/listingPrice/subcategory[1]/averageListingPrice").text

    greatschools_key = "dvfn2l6v3epdlebuzjr5eaxx"
    greatschool_url = "http://api.greatschools.org/schools/nearby?key=#{greatschools_key}&state=#{state}&zip=#{zip}&radius=2"
    greatschool_result = Nokogiri::XML(open(greatschool_url))
    @schools = greatschool_result.xpath("/schools")
  end
end


