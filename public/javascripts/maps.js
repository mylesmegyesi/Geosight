var lastOpenedPhotos = null; // the last opened infowindow
/* adds photo markers to the map
*   map - the map the marker will be added to
*   lat - latitude
*   lng - longitude
*   cent - center
* 	 contentString - the HTML to be displayed by the accompanying infowindows
*   lastOpened - the last opened infowindow
*/
function add_photo_marker(pid, map, cent) { 
	$.getJSON("/photos/"+pid, function(json) {

	var contentString = "<b>Photo "+json.id+"</b>" +
		"<div id= 'infoWindowDiv'>" +
			"<a href=/photos/"+json.id+">";
				if (json.thumbnail != null) {
					contentString += "<img src="+json.thumbnail+">";
				} else {
					contentString += "Photo Unavailable";
				} contentString +=
			"</a>" +
		"</div>"; 


    var latlng = new google.maps.LatLng(json.latitude, json.longitude);
  
    var marker = new google.maps.Marker({
        position: latlng,
        map: map
    });
    marker.infowindow = new google.maps.InfoWindow({
      content: contentString,
    });

    // pops up an infowindow when you click on a marker
    google.maps.event.addListener(marker, 'click', function() {
        if(lastOpenedPhotos != null) lastOpenedPhotos.infowindow.close();
        marker.infowindow.open(map,marker);
        lastOpenedPhotos = marker;
    });
    // recenters map when you close an infowindow
    google.maps.event.addListener(marker.infowindow,'closeclick', function() {
        map.setCenter(cent);
        lastOpenedPhotos = null;
    });
  });
}

var lastOpenedSight = null; // the last infowindow opened
/* adds sight markers to the map
* map - the map the marker will be added to
* lat - latitude
* lng - longitude
* rad - the radius of the sight in meters
* title - the name of the sight
* contentString - the HTML to be displayed by the accompanying infowindows
* lastOpened - the last opened infowindow
*/
function add_sight_marker(sid, map, lastOpened) { 
	$.getJSON("/sights/"+sid, function(json) {
		contentString = "<b>"+json.name+"</b>" +
			"<div id= 'infoWindowDiv'>" +
				"<a href=/sights/"+json.id+">";
					if (json.small != null) {
						contentString += "<img src="+json.small+">";
					} else {
						contentString += "No Photos Yet";
					} contentString +=
				"</a>" +
			"</div>"; 


      var latlng = new google.maps.LatLng(json.latitude, json.longitude);
    
      var marker = new google.maps.Marker({
          position: latlng,
          title: json.name,
          map: map
      });
  
      marker.infowindow = new google.maps.InfoWindow({
          content: contentString,
      });

      // makes clicking on a marker popup the infowindow associated with it
      google.maps.event.addListener(marker, 'click', function() {
          if(lastOpenedSight != null) lastOpenedSight.infowindow.close();
          marker.infowindow.open(map,marker);
          lastOpenedSight = marker;
      });  

	  var circle = new google.maps.Circle({
          radius: json.radius,
          center: latlng,
          map: map,
          strokeWeight: 1
	  });
   });
}


var lastOpenedPhoto = null;
/*
* adds photo markers to the map for individual photos (views/photos/show.html.erb)
*   map - the map the marker will be added to
*   lat - latitude
*   lng - longitude
*   cent - center
* 	 contentString - the HTML to be displayed by the accompanying infowindows
*   lastOpened - the last opened infowindow
*/
function add_marker(pid, map, contentString) {
	$.getJSON("/photos/"+pid, function(json) {

     var latlng = new google.maps.LatLng(json.latitude, json.longitude);
    
     var marker = new google.maps.Marker({
       position: latlng,
       map: map
     });
       
     marker.infowindow = new google.maps.InfoWindow({
       content: contentString,
     });
    
     // pops up an infowindow when you click on a marker
     google.maps.event.addListener(marker, 'click', function() {
        if(lastOpenedPhoto != null) lastOpenedPhoto.infowindow.close();
        marker.infowindow.open(map,marker);
        lastOpenedPhoto = marker;
        
     });
    
     // recenters map when you close an infowindow
     google.maps.event.addListener(marker.infowindow,'closeclick', function() {
       map.setCenter(new google.maps.LatLng(json.latitude, json.longitude));
       lastOpenedPhoto = null;
     });
  });
}






/*
// to preload images in infowindows
function swapsource_and_dosomething(url,handler,element){
  var img=new Image();
  img.onload=function(){
    element.src= url;
    return handler(element);
  }
  img.src=url;
}
*/
