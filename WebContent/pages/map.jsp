<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html>

<html>
<head>
	<title>Glassdoor: an inside look at jobs & companies</title>
	<!-- Meta -->
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">    
    <link rel="shortcut icon" href="favicon.ico">  
    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,300italic,400italic' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>  
	<!-- Global CSS -->
	<link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css">   
	<link rel="stylesheet" href="assets/css/screen.css" />
	<!-- Plugins CSS -->  
	<link rel="stylesheet" href="assets/plugins/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="assets/plugins/animate-css/animate.min.css">
    <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7/leaflet.css" />
    <link rel="stylesheet" href="assets/css/MarkerCluster.css" />
	<link rel="stylesheet" href="assets/css/MarkerCluster.Default.css" />
    <!-- Theme CSS -->  
    <link id="theme-style" rel="stylesheet" href="assets/css/styles.css"/>
    
    <script src="http://cdn.leafletjs.com/leaflet-0.7/leaflet.js"></script>
    <script type="text/javascript" src="assets/js/leaflet.markercluster-src.js"></script>
    <script type="text/javascript" src="assets/js/main.js"></script>   
    <script type="text/javascript" src="assets/js/geojson-sample.js"></script>
	
</head>

<body>
	<div id="map"></div>
	<script type="text/javascript">
		var tiles = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
				maxZoom: 18,
				attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
			}),
			latlng = L.latLng(0.78, 102.37);
		var map = L.map('map', {center: latlng, zoom: 7, layers: [tiles]});
		var geojson = L.geoJson(geojsonSample, {
			style: function (feature) {
				return {color: feature.properties.color};
			},
			onEachFeature: function (feature, layer) {
				var popupText = 'geometry type: ' + feature.geometry.type;
				if (feature.properties.color) {
					popupText += '<br/>color: ' + feature.properties.color
				}
				layer.bindPopup(popupText);
			}
		});
		geojson.addLayer(new L.Marker(new L.LatLng(2.745530718801952, 105.194091796875)))
		var eye1 = new L.Marker(new L.LatLng(-0.7250783020332547, 101.8212890625));
		var eye2 = new L.Marker(new L.LatLng(-0.7360637370492077, 103.2275390625));
		var nose = new L.Marker(new L.LatLng(-1.3292264529974207, 102.5463867187));
		var mouth = new L.Polyline([
			new L.LatLng(-1.3841426927920029, 101.7333984375),
			new L.LatLng(-1.6037944300589726, 101.964111328125),
			new L.LatLng(-1.6806671337507222, 102.249755859375),
			new L.LatLng(-1.7355743631421197, 102.67822265625),
			new L.LatLng(-1.5928123762763, 103.0078125),
			new L.LatLng(-1.3292264529974207, 103.3154296875)
		]);
		
		var markers = L.markerClusterGroup();
		markers.addLayer(geojson).addLayers([eye1,eye2,nose,mouth]);
		map.addLayer(markers);
	</script>
	
	<!-- Javascript -->  
	<script type="text/javascript" src="assets/plugins/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="assets/plugins/jquery-migrate-1.2.1.min.js"></script>
    <script type="text/javascript" src="assets/plugins/detectmobilebrowser.js"></script> 
    <script type="text/javascript" src="assets/plugins/bootstrap/js/bootstrap.min.js"></script> 
    <script type="text/javascript" src="assets/plugins/back-to-top.js"></script>
    <script type="text/javascript" src="assets/plugins/jquery-placeholder/jquery.placeholder.js"></script>
    <script type="text/javascript" src="assets/plugins/jquery-inview/jquery.inview.min.js"></script>
    <script type="text/javascript" src="assets/plugins/FitVids/jquery.fitvids.js"></script>  
	       
    
</body>
</html>
