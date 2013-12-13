# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
if ("#map").length > 0
  $ ->
    map = L.map("map").setView([gon.set_lat, gon.set_long], 13);
    L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png",
      attribution: "&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors"
    ).addTo map
    i = 0
    while i < gon.lat.length
      # school =
      #   name: gon.school_name[i]
      # name = gon.school_name[i]
      # marker = L.marker([gon.lat[i],gon.long[i]]).bindPopup(_.template(school_html, school)).addTo(map)
      marker = L.marker([gon.lat[i],gon.long[i]]).bindPopup("<b>" + gon.school_name[i] + "</b>" + " (" + gon.school_type[i] + ")" + "<br>" + gon.phone[i] + "<br>" + gon.school_address[i]).addTo(map)
      i++