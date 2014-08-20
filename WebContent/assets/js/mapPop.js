var placeSearch, autocomplete;
var startPlace, endPlace;

function placeInitialize() {
  startPlace = document.getElementById('start').value;
  endPlace = document.getElementById('end').value;

	
  $( "#getRoute" ).click(function() {
	  calcRoute();
  });
  
  var autocompleteStart = new google.maps.places.Autocomplete(
	 (document.getElementById('start')),
      { types: ['geocode'] });
  google.maps.event.addListener(autocompleteStart, 'place_changed', function() {
	startPlace = autocompleteStart.getPlace().name;
	calcRoute();
  });
  
  var autocompleteEnd = new google.maps.places.Autocomplete(
		  (document.getElementById('end')), { types: ['geocode'] });

  google.maps.event.addListener(autocompleteEnd, 'place_changed', function() {
    endPlace = autocompleteEnd.getPlace().name;
	calcRoute();
  });
}

var rendererOptions = {
  draggable: true
};
var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);;
var directionsService = new google.maps.DirectionsService();
var routingmap;

var australia = new google.maps.LatLng(-25.274398, 133.775136);

function mapInitialize() {
	var mapOptions = {
    zoom: 7,
    center: australia
  };
  routingmap = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  directionsDisplay.setMap(routingmap);
  directionsDisplay.setPanel(document.getElementById('directionsPanel'));

  google.maps.event.addListener(directionsDisplay, 'directions_changed', function() {
    computeTotalDistance(directionsDisplay.getDirections());
  });
  calcRoute();
}

function calcRoute() {
  var selectedMode = document.getElementById("mode").value;
  var request = {
    origin: startPlace,
    destination: endPlace,
    travelMode: google.maps.TravelMode[selectedMode],
	provideRouteAlternatives: true,
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    }
  });
}

function computeTotalDistance(result) {
  var total = 0;
  var myroute = result.routes[0];
  for (var i = 0; i < myroute.legs.length; i++) {
    total += myroute.legs[i].distance.value;
  }
  total = total / 1000.0;
  document.getElementById('total').innerHTML = total + ' km';
}

//google.maps.event.addDomListener(window, 'load', initialize);
