$(document).ready(function(){

	var map = L.map('map').setView([37.789260, -122.402243], 13);
//	var map = L.map('map').setView([40.442493, -79.942553], 13);
	
	L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
//	L.tileLayer('http://{s}.tile.stamen.com/watercolor/{z}/{x}/{y}.png').addTo(map);
	
	
	var marker1 = L.marker([37.789260, -122.402243]).addTo(map);
	marker1.bindPopup("Opentable");
	var marker2 = L.marker([37.771883, -122.405224]).addTo(map);
	marker2.bindPopup("Airbnb");
	var marker3 = L.marker([37.793988, -122.394954]).addTo(map);
	marker3.bindPopup("Salesforce");
	var marker4 = L.marker([37.773160, -122.403933]).addTo(map);
	marker4.bindPopup("Pinterest");
	var marker5 = L.marker([37.786664, -122.399774]).addTo(map);
	marker5.bindPopup("Yelp");
	
//	map.locate({setView: true, maxZoom: 15});
//	map.on('locationfound', onLocationFound);
	
//	function onLocationFound(e) {
//	    // create a marker at the users "latlng" and add it to the map
//	    L.marker(e.latlng).addTo(map);
//	}

});