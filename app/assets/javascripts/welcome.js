if ("#map".length > 0) {
  $(function() {

    // Initializing the map
    var map, marker;
    map = L.map("map").setView([gon.set_lat, gon.set_long], 14);
    L.tileLayer("http://{s}.tile.cloudmade.com/628dba99fedb4efab19b7c389cbffc90/116757/256/{z}/{x}/{y}.png", {
      attribution: "&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors, Imagery © <a href=\"http://cloudmade.com\">CloudMade</a>"
    }).addTo(map);

    // Array created to push all of the schools
    var markerArray = []

    // Assigning icon for type of school on the map
    var assignIcon = function(type, grade_range) {
      if (type == "public") {
        if (grade_range == "K-6" || grade_range == "PK-6" || grade_range == "K-5" || grade_range == "PK-5" || grade_range == "K-4" || grade_range == "5-6") {
          return icon.publicElementary;
        }
        else if (grade_range == "6-8" || grade_range == "7-8") {
          return icon.publicMiddle;
        }
        else if (grade_range == "9-12") {
          return icon.publicHigh;
        }
        else {
          return icon.otherPublic;
        }
      }
      else {
        if (grade_range == "K-6" || grade_range == "PK-6" || grade_range == "K-5" || grade_range == "PK-5" || grade_range == "K-4" || grade_range == "5-6") {
          return icon.privateElementary;
        }
        else if (grade_range == "6-8" || grade_range == "7-8") {
          return icon.privateMiddle;
        }
        else if (grade_range == "9-12") {
          return icon.privateHigh;
        }
        else {
          return icon.otherPrivate;
        }
      }
    };

    // Assigning each school an icon & placing on the map
    // Push marker into markerArray in orer to interact with
    // openPopup when a school is selected from the list
    for (var i = 0; i < gon.lat.length; i++) {
      var ncesURL = "http://nces.ed.gov/ccd/schoolsearch/school_detail.asp?Search=1&SchoolID=" + gon.ncesid[i] + "&SchoolType=1&SchoolType=2&SchoolType=3&SchoolType=4&SpecificSchlTypes=all&IncGrade=-1&LoGrade=-1&HiGrade=-1&ID=" + gon.ncesid[i]
      marker = L.marker([gon.lat[i], gon.long[i]], {
        title: gon.gsid[i],
        icon: assignIcon(gon.school_type[i], gon.grade_range[i])
      }).bindPopup('<a href=' + ncesURL + '>' + gon.school_name[i] + '</a>' + " (" + gon.school_type[i] + ")" + "<br>" + gon.phone[i] + "<br>" + gon.school_address[i]).addTo(map);
      markerArray.push(marker);
    }

    // Specifically for opening the popup
    var markerFunction = function(id) {
      for (var i in markerArray) {
        var markerID = markerArray[i].options.title;
        if (markerID == id) {
          markerArray[i].openPopup();
        };
      }
    }

    // Opens popup + zooms to school when selected from list
    $('.school_list').click(function() {
      var school_information = $(this).attr('id');
      school_information = school_information.split(",");
      map.panTo([school_information[1],school_information[2]]);
      markerFunction(school_information[0]);
    });

    // Zooms to school when you click on the marker
    $('.leaflet-clickable').click(function() {
      var school_gsid = $(this).attr('title');
      for (var i in markerArray) {
        var markerID = markerArray[i].options.title;
        if (markerID == school_gsid) {
          map.panTo(markerArray[i].getLatLng());
        }
      }
    })
  });
}

var icon = {}

// Using Awesome Markers to create icons for school categories
icon.publicElementary = L.AwesomeMarkers.icon({
  icon: 'circle',
  iconColor: 'white',
  markerColor:'blue',
  prefix: 'fa'
});
icon.privateElementary = L.AwesomeMarkers.icon({
  icon: 'circle',
  iconColor: 'black',
  markerColor:'blue',
  prefix: 'fa'
});
icon.publicMiddle = L.AwesomeMarkers.icon({
  icon: 'circle',
  iconColor: 'white',
  markerColor:'green',
  prefix: 'fa'
});
icon.privateMiddle = L.AwesomeMarkers.icon({
  icon: 'circle',
  iconColor: 'black',
  markerColor:'green',
  prefix: 'fa'
});
icon.publicHigh = L.AwesomeMarkers.icon({
  icon: 'circle',
  iconColor: 'white',
  markerColor:'red',
  prefix: 'fa'
});
icon.privateHigh = L.AwesomeMarkers.icon({
  icon: 'circle',
  iconColor: 'black',
  markerColor:'red',
  prefix: 'fa'
});
icon.otherPublic = L.AwesomeMarkers.icon({
  icon: 'circle',
  iconColor: 'white',
  markerColor:'darkpurple',
  prefix: 'fa'
});
icon.otherPrivate = L.AwesomeMarkers.icon({
  icon: 'circle',
  iconColor: 'black',
  markerColor:'darkpurple',
  prefix: 'fa'
});