# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
if ("#map").length > 0
  $ ->
    map = L.map("map").setView([gon.set_lat, gon.set_long], 13);
    L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png",
      attribution: "&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors"
    ).addTo map