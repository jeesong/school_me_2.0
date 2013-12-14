
if ("#map".length > 0) {
  $(function() {
    var map, marker;
    map = L.map("map").setView([gon.set_lat, gon.set_long], 14);
    L.tileLayer("http://{s}.tile.cloudmade.com/628dba99fedb4efab19b7c389cbffc90/998/256/{z}/{x}/{y}.png", {
      attribution: "&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors, Imagery © <a href=\"http://cloudmade.com\">CloudMade</a>"
    }).addTo(map);

    var markerArray = []

    for (var i = 0; i < gon.lat.length; i++) {
      marker = L.marker([gon.lat[i], gon.long[i]], {
        title: gon.gsid[i]
      }).bindPopup("<b>" + gon.school_name[i] + "</b>" + " (" + gon.school_type[i] + ")" + "<br>" + gon.phone[i] + "<br>" + gon.school_address[i]).addTo(map);
      markerArray.push(marker);
    }
    console.log(markerArray[0]);
    var markerFunction = function(id) {
    // function markerFunction(id) {
      for (var i in markerArray) {
        var markerID = markerArray[i].options.title;
        if (markerID == id) {
          markerArray[i].openPopup();
        };
      }
    }
    $('.school_list').click(function() {
      var school_coordinates = $(this).attr('id');
      school_coordinates = school_coordinates.split(",");
      map.panTo([school_coordinates[1],school_coordinates[2]]);
      markerFunction(school_coordinates[0]);
    });
    $('.leaflet-marker-icon').click(function() {
      // alert("this also worked");
    })
  });
}
