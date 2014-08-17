<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
    <link rel="stylesheet" type="text/css" href="../assets/css/screen.min.css" media="screen,projection" /> 
    <link rel="stylesheet" type="text/css" href="../assets/css/smoothness/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" href="../assets/libraries/font-awesome/css/font-awesome.css" media="screen, projection">
    <link rel="stylesheet" type="text/css" href="../assets/libraries/jquery-bxslider/jquery.bxslider.css" media="screen, projection">
    <link rel="stylesheet" type="text/css" href="../assets/libraries/flexslider/flexslider.css" media="screen, projection">
    <link rel="stylesheet" type="text/css" href="../assets/css/realocation.css" media="screen, projection" id="css-main">
    
    <link href="http://fonts.googleapis.com/css?family=Raleway:400,700" rel="stylesheet" type="text/css">
    
    <script src="http://www.google.com/jsapi?key=AIzaSyA0APLVAS_phz0CE0stfzyy5yq0e25qdi0;sensor=false" type="text/javascript"></script>
    <script src="http://maps.googleapis.com/maps/api/js?libraries=places&sensor=false" type="text/javascript"></script>
    <script src="../assets/js/jquery-all.js" type="text/javascript" charset="utf-8"></script>
    
    <title>
        Glassdoor | Get Hired. Love Your Job
    </title>
</head>

<body class="header-light map-navigation-light footer-light">
<div id="wrapper">
    <div id="header-wrapper">
        <div id="header">
    <div id="header-inner">
        <div class="header-bar">
            <div class="container">
                <ul class="header-bar-nav nav nav-register">
    <li><a href="login.html">Login</a></li>
    <li><a href="register.html">Register</a></li>
    <li><a href="renew-password.html">Renew Password</a></li>
</ul>            </div><!-- /.container -->
        </div><!-- /.header-bar -->

        <div class="header-top">
            <div class="container">
                <div class="header-identity">
                    <a href="index.html" class="header-identity-target">
                        <span class="header-icon"><i class="fa fa-home"></i></span>
                        <span class="header-title">glassdoor</span><!-- /.header-title -->
                        <span class="header-slogan">Get Hired. <br> Love Your Job.</span><!-- /.header-slogan -->
                    </a><!-- /.header-identity-target-->
                </div><!-- /.header-identity -->

                <div class="header-actions pull-right">
					<strong style="color: #39b54a"> Map - Job Matching </strong> Feature <br /> 
					Enables Easier Job Hunting
				</div><!-- /.header-actions -->

                <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".header-navigation">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div><!-- /.container -->
        </div><!-- .header-top -->

        <div class="header-navigation">
            <div class="container">
                <div class="row">
                	<!-- menu -->
                    <ul class="header-nav nav nav-pills">
					    <li><a href="#">Home</a></li>
						<li><a href="#">Jobs</a></li>
						<li><a href="#">Map</a></li>
						<li><a href="#">Companies</a></li>
						<li><a href="#">Salaries</a></li>
						<li><a href="#">Interviews</a></li>
					</ul><!-- /.header-nav -->
					
					<!-- search bar -->
                    <div class="form-search-wrapper col-sm-3">
                        <form method="post" action="?" class="form-horizontal form-search">
                            <div class="form-group has-feedback no-margin">
                                <input type="text" class="form-control" placeholder="Quick Search">

                                <span class="form-control-feedback">
                                    <i class="fa fa-search"></i>
                                </span><!-- /.form-control-feedback -->
                            </div><!-- /.form-group -->
                        </form>
                    </div>
                </div>
            </div><!-- /.container -->
        </div><!-- /.header-navigation -->
    </div><!-- /.header-inner -->
</div><!-- /#header -->    
</div><!-- /#header-wrapper -->
<div id="main-wrapper">
    <div id="main">
        <div id="main-inner">

<!-- MAP -->
<div class="block-content no-padding" >
    <div class="block-content-inner">
    
        <div class="map-wrapper">
            <div id="map"></div>
            <div id="controls" class="controlsoverlay"></div>
	        <div id="message" class="shortoverlay" style="display:none"></div>
	        
            <div class="container">
            	<div class="row">
					<div class="col-sm-3 col-sm-offset-0 col-md-3 col-md-offset-0 map-navigation-positioning">
						<div class="map-navigation-wrapper">
							<div class="map-navigation">
								<form method="post" action="?" class="clearfix">
									<div class="form-group col-sm-12">
										<div id="color-map-container"></div>
									</div>
									<div class="form-group col-sm-12">
										<div id="intersect-container"></div>
									</div>
									<div class="form-group col-sm-12">
										<div style="display: inline-block" id="urbanDistance-markerrepo" class="markerrepo"><img id="urbanDistance-markerrepo-marker" class="markerrepo-marker" src="../assets/img/icons/marker4.png" alt="New Starting Point"/></div>
										<label>Drop Me On The Map</label>
									</div><!-- /.form-group -->
									
									<div class="form-group col-sm-12">
										<label>Search Nearby Places</label>
										<input type="text" id="urbanDistance-search" placeholder="e.g. Coffee">
									</div><!-- /.form-group -->
									
									<div class="form-group col-sm-12">
										<input type="submit" class="btn btn-primary btn-inversed btn-block" value="Search Nearby"/>
									</div>
									<!-- /.form-group -->
								</form>
							</div>
							<!-- /.map-navigation -->
						</div>
						<!-- /.map-navigation-wrapper -->
					</div>
					<!-- /.col-sm-3 -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.container -->

        </div><!-- /.map-wrapper -->
    </div><!-- /.block-content-inner -->
</div><!-- /.block-content -->
            
        </div><!-- /#main-inner -->
    </div><!-- /#main -->
</div><!-- /#main-wrapper -->

    <div id="footer-wrapper">
        <div id="footer">
            <div id="footer-inner">
                
                <div class="footer-bottom">
                    <div class="container">
                        <p class="center no-margin">
                            &copy; 2014 Glassdoor Practicum Team, All Right reserved
                        </p>

                        <div class="center">
                            <ul class="social">
                                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                                <li><a href="#"><i class="fa fa-flickr"></i></a></li>
                                <li><a href="#"><i class="fa fa-pinterest"></i></a></li>
                                <li><a href="#"><i class="fa fa-youtube"></i></a></li>
                                <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                <li><a href="#"><i class="fa fa-vimeo-square"></i></a></li>
                                <li><a href="#"><i class="fa fa-dribbble"></i></a></li>
                            </ul><!-- /.social -->
                        </div><!-- /.center -->
                    </div><!-- /.container -->
                </div><!-- /.footer-bottom -->
            </div><!-- /#footer-inner -->
        </div><!-- /#footer -->
    </div><!-- /#footer-wrapper -->
</div><!-- /#wrapper -->

        
        
        
        
        
        
        <script src="../assets/js/main.js" type="text/javascript" charset="utf-8"></script>
        
        <script type="text/javascript" charset="utf-8">
            var mapnificent;
            (function(){
                var search = document.location.search;
                if (search.indexOf('hidecopyright') !== -1) {
                    $('#copyright-notice').hide();
                }
                if (search.indexOf('hidecontrols') !== -1) {
                    $('#controls').hide();
                }
                var options = {"mapStartCenter": {"lat": 40.4406248, "lng": -79.9958864},
                        "mapStartZoom": 12,
                        "dataUrlPrefix": "http://mapnificent.stefanwehrmeyer.com/data/",
                        "layerSettings": {"urbanDistance": {"estimatedMaxCalculateCalls": 15000,"calculateOnDrag": true}}
                    };
                var version = '1';
                if (search.indexOf('version') !== -1) {
                    version = search.substring(1).split('=')[1];
                }
                options.layerSettings.urbanDistance.cityData = 'pittsburgh-' + version;
                options.layerSettings.urbanDistance.northwest = {"lat":40.668947, "lng":-80.255573};
                options.layerSettings.urbanDistance.southeast = {"lat":40.273021, "lng":-79.707664};
                options.layerSettings.urbanDistance.copyright = "\x3Cp\x3E(c) \x3Ca href\x3D\x22http://www.portauthority.org/\x22\x3EPittsburgh Port Authority\x3C/a\x3E\x3C/p\x3E";
                mapnificent = Mapnificent(options);
            }());
            mapnificent.addLayer("urbanDistance", UrbanDistanceUI); 
            
            
            var google_init = function(){
                if(!Mapnificent.isBrowserSupported()){
                  $("#controls").hide();
                  $("#topnav").hide();
                  $("#copyright-notice").hide();
                  $('<div id="browsers">'+
					  '<h2>Your current browser does not seem to support Mapnificent!</h2>'+
					  '<p>Please choose a different one:</p>'+
					  '<table>'+
					    '<tr><td><a href="http://www.google.com/chrome/"><img src="/media/img/chrome-logo.png" alt="Google Chrome"/><br/>Chrome</a></td>'+
					    '<td><a href="http://getfirefox.com/"><img src="/media/img/firefox-logo.png" alt="Firefox"/><br/>Firefox</a></td>'+
					    '<td><a href="http://www.opera.com/"><img src="/media/img/opera-logo.png" alt="Opera"/><br/>Opera</a></td>'+
					    '<td><a href="http://www.apple.com/safari/"><img src="/media/img/safari-logo.png" alt="Apple Safari"/><br/>Safari</a></td>'+
					  '</tr></table>'+
					'</div>').appendTo("body");
                  return;
                }
                mapnificent.initMap("map");
                jQuery(".toggle").live("click", function(e){
                    e.preventDefault();
                    var obj = jQuery(jQuery(this).attr("href"));
                    if(obj.css("display") == "none"){
                        obj.fadeIn(400);
                    } else {
                        obj.fadeOut(400);
                    }
                });
            };
            
            google.setOnLoadCallback(google_init);
        </script>
    </body>
</html>
