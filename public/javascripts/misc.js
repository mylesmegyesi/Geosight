/*
* Set up the jump box
*   Uses Google geocoding api to center view around
*   a location, mapping strings to coordinates
*/
function setUpJumpBox(map) {
  var geocoder = new google.maps.Geocoder();
  $("#jump-submit").click(function() {
      var query = $("#jump-to").val();
      if (query == "") {
          return;
      }
      
      $("#spinner").show();
      geocoder.geocode({"address": query}, function(results, status) {
          $("#spinner").hide();
          if (status == google.maps.GeocoderStatus.OK) {
              var location = results[0].geometry.location;
              map.setCenter(location);
              map.setZoom(15);
          } else {
              alert("Could not find the given location");
          }
      });
  });
}
