<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
<title>Glassdoor: an inside look at jobs & companies</title>
<!-- Meta -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="assets/img/favicon.ico"  type="image/x-icon" >
<link
	href='http://fonts.googleapis.com/css?family=Lato:300,400,300italic,400italic'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Montserrat:400,700'
	rel='stylesheet' type='text/css'>
<!-- Global CSS -->
<link rel="stylesheet"
	href="assets/plugins/bootstrap/css/bootstrap.min.css">
<!-- Plugins CSS -->
<link rel="stylesheet"
	href="assets/plugins/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="assets/plugins/animate-css/animate.min.css">
<!-- Theme CSS -->
<link id="theme-style" rel="stylesheet" href="assets/css/styles.css">
<link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.css" />
<link rel="stylesheet" href="screen.css" />

	<link rel="stylesheet" href="dist/MarkerCluster.css" />
	<link rel="stylesheet" href="dist/MarkerCluster.Default.css" />
	<script src="dist/leaflet.markercluster-src.js"></script>
	<script type="text/javascript" src="geojson-sample.js"></script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body class="home-page">

	<div class="wrapper">
		<!-- ******HEADER****** -->
		<header id="header" class="header">
			<div class="container">
				<h1 class="logo pull-left">
					<a href="index.jsp"> 
						<img src = "assets/images/companies/glassdoor.png">
						<span class="logo-title">glassdoor</span>
					</a>
				</h1>
				
				<!--//logo-->
				<nav id="main-nav" class="main-nav navbar-right" role="navigation">
					<div class="navbar-header">
						<button class="navbar-toggle" type="button" data-toggle="collapse"
							data-target="#navbar-collapse">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
						<!--//nav-toggle-->
					</div>
					<!--//navbar-header-->
					<div class="navbar-collapse collapse" id="navbar-collapse">
						<ul class="nav navbar-nav">
							<li class="nav-item"><a href="jobs.jsp">Jobs</a></li>
							<li class="nav-item"><a href="tour.html">Companies</a></li>
							<li class="nav-item"><a href="pricing.html">Salaries</a></li>
							<li class="nav-item"><a href="blog.html">Interviews</a></li>
							<li class="nav-item"><a href="contact.html">Map</a></li>
							<li class="nav-item nav-item-cta last"><a
								class="btn btn-cta btn-cta-primary" href="pricing.html">Login</a></li>
						</ul>
						<!--//nav-->
					</div>
					<!--//navabr-collapse-->

					<div class="fixed-container"></div>
				</nav>
				<!--//main-nav-->
			</div>
			<!--//container-->
		</header>
		<!--//header-->
		
		<!-- ******BLOG LIST****** --> 
        <div class="blog container">
            <div class="container">
            <div class="row">
            	<div class="col-lg-3">
            		<ul class="list-unstyled">
            			<li><h4>OpenTable</h4></li>
            			<li>1 Montgomery Street, Suite 700 San Francisco, CA 94104</li>
            			
            			<li><h4>Airbnb</h4></li>
            			<li>888 Brannan St, San Francisco, CA 94103</li>
            			
            			<li><h4>Salesforce</h4></li>
            			<li>1 Market St #300, San Francisco, CA 94105</li>
            			
            			<li><h4>Pinterest</h4></li>
            			<li>572 7th St, San Francisco, CA 94103</li>
            			
            			<li><h4>Yelp</h4></li>
            			<li>140 New Montgomery Street San Francisco, CA 94105</li>
            		</ul>
					
				</div>
				<div class="col-lg-9">
					<div id="map" style = "height: 400px;"></div>
					<!-- <div id="map"></div> -->
	<span>Mouse over a cluster to see the bounds of its children and click a cluster to zoom to those bounds</span>
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
					</div> 
				</div>
			
						    	
		</div><!--//blog-->
		<div class="blog container"></div>
		</div>
		</div>
		<!-- ******FOOTER****** -->
	<footer class="footer">
		<div class="footer-content">
			<div class="container">
				<div class="row">
					<div class="footer-col col-md-5 col-sm-7 col-sm-12 about">
						<div class="footer-col-inner">
							<h3 class="title">About Us</h3>
							<p>Glassdoor is your free inside look at jobs and companies. 
							Salary details, company reviews, and interview questions &#8212; 
							all posted anonymously by employees and job seekers.</p>
							

						</div>
						<!--//footer-col-inner-->
					</div>
					<!--//foooter-col-->
					<div class="footer-col col-md-3 col-sm-4 col-md-offset-1 links">
						<div class="footer-col-inner">
							<ul class="list-unstyled">
								<li><a href="#"><i class="fa fa-caret-right"></i>Employers</a></li>
								<li><a href="#"><i class="fa fa-caret-right"></i>Careers</a></li>
								<li><a href="#"><i class="fa fa-caret-right"></i>API</a></li>
								<li><a href="#"><i class="fa fa-caret-right"></i>Blog</a></li>
								<li><a href="#"><i class="fa fa-caret-right"></i>Feedback</a></li>
								<li><a href="#"><i class="fa fa-caret-right"></i>Help</a></li>
								<li><a href="#"><i class="fa fa-caret-right"></i>Post a Job</a></li>
							</ul>
						</div>
						<!--//footer-col-inner-->
					</div>
					<!--//foooter-col-->
					<div class="footer-col col-md-3 col-sm-12 contact">
						<div class="footer-col-inner">
							<h3 class="title">Get in touch</h3>
							<div class="row">
								<p class="tel col-md-12 col-sm-4">
									<i class="fa fa-phone"></i>0800 123 4567
								</p>
								<p class="email col-md-12 col-sm-4">
									<i class="fa fa-envelope"></i><a href="#">support@website.com</a>
								</p>
								<p class="email col-md-12 col-sm-4">
									<i class="fa fa-comment"></i><a href="#">Live Chat</a>
								</p>
							</div>
						</div>
						<!--//footer-col-inner-->
					</div>
					<!--//foooter-col-->
				</div>
				<!--//row-->
			</div>
			<!--//container-->
		</div>
		<!--//footer-content-->
		<div class="bottom-bar">
			<div class="container">
				<div class="row">
					<small class="copyright col-md-6 col-sm-6 col-xs-12">Copyright
						@ 2014 Glassdoor Practicum Team
					</small>
					
				</div>
				<!--//row-->
			</div>
			<!--//container-->
		</div>
		<!--//bottom-bar-->
	</footer>
	<!--//footer-->
		<!-- Javascript -->
	<script type="text/javascript"
		src="assets/plugins/jquery-1.10.2.min.js"></script>
	<script type="text/javascript"
		src="assets/plugins/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript"
		src="assets/plugins/detectmobilebrowser.js"></script>
	<script type="text/javascript"
		src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="assets/plugins/back-to-top.js"></script>
	<script type="text/javascript"
		src="assets/plugins/jquery-placeholder/jquery.placeholder.js"></script>
	<script type="text/javascript"
		src="assets/plugins/jquery-inview/jquery.inview.min.js"></script>
	<script type="text/javascript"
		src="assets/plugins/FitVids/jquery.fitvids.js"></script>
	<script type="text/javascript" src="assets/js/main.js"></script>
	<!--[if !IE]>-->
	<script type="text/javascript" src="assets/js/animations.js"></script>
	<!-- <script type="text/javascript" src="assets/js/map_leaflet.js"></script> -->
	<script type="text/javascript" src="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.js"></script> 
	<!--<![endif]-->

</body>
</html>