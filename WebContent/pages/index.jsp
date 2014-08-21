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

    <link rel="shortcut icon" href="assets/img/favicon.ico"  type="image/x-icon" >
    <link rel="stylesheet" type="text/css" href="assets/libraries/font-awesome/css/font-awesome.css" media="screen, projection">
    <link rel="stylesheet" type="text/css" href="assets/libraries/jquery-bxslider/jquery.bxslider.css" media="screen, projection">
    <link rel="stylesheet" type="text/css" href="assets/libraries/flexslider/flexslider.css" media="screen, projection">
    <link rel="stylesheet" type="text/css" href="assets/css/realocation.css" media="screen, projection" id="css-main">

    <link href="http://fonts.googleapis.com/css?family=Raleway:400,700" rel="stylesheet" type="text/css">

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
				    <li><a href="index/login">Login</a></li>
				    <li><a href="index/register">Register</a></li>
				</ul>            
			</div><!-- /.container -->
        </div><!-- /.header-bar -->

        <div class="header-top">
            <div class="container">
                <div class="header-identity">
                    <a href="#" class="header-identity-target">
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
						<li><a href="index/searchJob?keyword=Software Engineer&location=Pittsburgh">Jobs</a></li>
						<li><a href="index/map">Local</a></li>
						<li><a href="index/profile">Profile</a></li>
					</ul><!-- /.header-nav -->
					
					<!-- search bar -->
                    <div class="form-search-wrapper col-sm-3">
                        <form id="search-form" method="post" action="index/search" class="form-horizontal form-search">
                            <div class="form-group has-feedback no-margin">
                                <input id="quick-search" name="keyword" type="text" class="form-control" placeholder="Quick Search">
                                <input type="hidden" name="location" value="Pittsburgh"/>
                                <script>
                                $("#quick-search").keydown(function(e) { 
                        			if (e.keyCode === 13) {
                        				$("#search-form").submit();
                        			} 
                        		});
                                </script>
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
</div><!-- /#header -->    </div><!-- /#header-wrapper -->
<div id="main-wrapper">
    <div id="main">
        <div id="main-inner">

<!-- MAP -->
<div class="block-content no-padding">
    <div class="block-content-inner">
        <div class="map-wrapper">
            <div id="map" data-style="2"></div><!-- /#map -->
            
            <div class="container">
				<div class="row">
					<div class="col-sm-4 col-sm-offset-8 col-md-3 col-md-offset-9 map-navigation-positioning">
						<div class="map-navigation-wrapper">
							<div class="map-navigation">
								<form action="index/search" method="post" class="clearfix">
									<div class="form-group col-sm-12">
										<label>Keyword</label>
										<input type="text" name="keyword" class="form-control" placeholder="Job Title">
									</div><!-- /.form-group -->
									
									<div class="form-group col-sm-12">
										<label>Location</label>
										<input type="text" name="location" class="form-control" placeholder="Location">
									</div><!-- /.form-group -->

									<div class="form-group col-sm-12">
										<input type="submit" class="btn btn-primary btn-inversed btn-block" value="Find Jobs">
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

<script type="text/javascript" src="assets/js/jquery.js"></script>
<script type="text/javascript" src="assets/libraries/isotope/jquery.isotope.min.js"></script>

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?v=3&amp;sensor=true"></script>
<script type="text/javascript" src="assets/js/gmap3.infobox.js"></script>
<script type="text/javascript" src="assets/js/gmap3.clusterer.js"></script>
<script type="text/javascript" src="assets/js/map.js"></script>

<script type="text/javascript" src="assets/libraries/bootstrap-sass/vendor/assets/javascripts/bootstrap/transition.js"></script>
<script type="text/javascript" src="assets/libraries/bootstrap-sass/vendor/assets/javascripts/bootstrap/collapse.js"></script>
<script type="text/javascript" src="assets/libraries/jquery-bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="assets/libraries/flexslider/jquery.flexslider.js"></script>
<script type="text/javascript" src="assets/js/jquery.chained.min.js"></script>
<script type="text/javascript" src="assets/js/realocation.js"></script>

</body>
</html>