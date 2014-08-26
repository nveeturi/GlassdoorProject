<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 


<!doctype html>

<html>
<head>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" href="../assets/img/favicon.ico"  type="image/x-icon" >
    <link rel="stylesheet" type="text/css" href="../assets/libraries/font-awesome/css/font-awesome.css" media="screen, projection">
    <link rel="stylesheet" type="text/css" href="../assets/libraries/jquery-bxslider/jquery.bxslider.css" media="screen, projection">
    <link rel="stylesheet" type="text/css" href="../assets/libraries/flexslider/flexslider.css" media="screen, projection">
    <link rel="stylesheet" type="text/css" href="../assets/css/realocation.css" media="screen, projection" id="css-main">
    <link rel="stylesheet" type="text/css" href="../assets/css/page/jobs.css" media="screen, projection" id="css-main">
    <link rel="stylesheet" type="text/css" href="../assets/css/pagination.css" />
    
    <link href="http://fonts.googleapis.com/css?family=Raleway:400,700" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../assets/js/jquery.js"></script>
    
    <script src="http://www.google.com/jsapi?key=AIzaSyA0APLVAS_phz0CE0stfzyy5yq0e25qdi0;sensor=false" type="text/javascript"></script>
	<script src="http://maps.googleapis.com/maps/api/js?libraries=places&sensor=false" type="text/javascript"></script>
    
    <title>
        Glassdoor | Get Hired. Love Your Job
    </title>
</head>

<body class="header-light map-navigation-light footer-light" onload="placeInitialize()">
<script>
	var totalnum = '${fn:length(joblist)}';
</script>

<div id="wrapper">
    <div id="header-wrapper">
        <div id="header"  class="fixedheader">
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
                    <a href="../" class="header-identity-target">
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
                    <ul class="header-nav nav nav-pills">
					    <li><a href="../">Home</a></li>
						<li><a href="searchJob?keyword=Software Engineer&location=Pittsburgh">Jobs</a></li>
						<li><a href="map">Local</a></li>
						<li><a href="profile">Profile</a></li>
					</ul><!-- /.header-nav -->
                    <div class="form-search-wrapper col-sm-3">
                        <form method="post" action="search" class="form-horizontal form-search">
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
            <div id="main-inner" style="margin-top:200px">
                    <div class="block-content no-padding">
                        <div class="block-content-inner">
                        	<div class="row">
                            	<div class="col-lg-4 col-sm-4" id="show">
                            		<div id="jobmap" data-style="2" style="height:560px"></div>
                            		<div id="show"></div>
                            	</div>
                            	
                            	<div class="col-sm-3" style="float:right">
                                    <div id="refinesearch" class="sidebar">
                                        <div class="sidebar-inner">
                                            <div class="widget">
                                            <h3 class="widget-title">Sort</h3>
        <div class="widget-content">
        <form method="post" action="sort">
            <div class="row">
                <div class="form-group col-sm-12">
                    <label>Sort By</label>
                    <div class="select-wrapper">
                    	<select id="sort-by" name="criteria" class="form-control">
							<option value="Distance" selected>Distance</option>
							<option value="CommuteTime">Commute Time</option>
						</select>
                    </div>
                </div><!-- /.form-group -->
                
                <div class="form-group col-sm-12"></div>
            </div><!-- /.row -->

            <div class="form-group">
                <input type="submit" value="Sort" class="btn btn-block btn-primary btn-inversed"/>
            </div><!-- /.form-group -->
        </form>
    </div><!-- /.widget-content -->
</div><!-- /.widget -->                                            

<div class="widget">
        <h3 class="widget-title">Filter</h3>
        <div class="widget-content">
        <form method="post" action="filter" >
            <div class="row">
                <div class="form-group col-sm-12">
                    <label>Distance</label>
                    <div class="select-wrapper">
                    	<select id="filter-distance" name = "distance" class="form-control" >
							<option value="Within 3 miles">Within 3 miles</option>
							<option value="Within 5 miles">Within 5 miles</option>
							<option value="Within 10 miles">Within 10 miles</option>
							<option value="Within 15 miles">Within 15 miles</option>
						</select>
                    </div>
                </div><!-- /.form-group -->
                
                <div class="form-group col-sm-12">
                    <label>Commute Time</label>
                    
                    <div class="select-wrapper">
                    	<select id="filter-time" name = "commuteTime" class="form-control">
							<option value="&lt; 15 min">&lt; 15 min</option>
							<option value="&lt; 30 min">&lt; 30 min</option>
							<option value="&lt; 60 min">&lt; 60 min</option>
						</select>
                    </div>
                </div><!-- /.form-group -->

                <div class="form-group col-sm-12">
                    <label>via</label>
                    
                    <div class="select-wrapper">
                    	<select id="filter-type" name = "commuteType" class="form-control">
							<option value="Drive">Drive</option>
							<option value="Public Transit">Public Transit</option>
							<option value="Walk">Walk</option>
							<option value="Bike">Bike</option>
						</select>
                    </div>
                </div><!-- /.form-group -->

                <div class="form-group col-sm-12"></div>
            </div><!-- /.row -->

            <div class="form-group">
                <input type="submit" value="Filter" class="btn btn-block btn-primary btn-inversed">
            </div><!-- /.form-group -->
        </form>
    </div><!-- /.widget-content -->
</div><!-- /.widget --> 
                                        </div><!-- /.sidebar-inner -->
                                    </div><!-- /.sidebar -->
                            </div><!-- /.row -->
                            <div id="blanket" style="display:none;"></div>
							<div id="popUpDiv" style="display:none;">
							
								<div id="popMap">
									<div>
								      <div style="height:40px">
								        <strong>Start: </strong>
								        <input type="text" id="start" value="5000 Forbes Ave, Pittsburgh, PA"></input>
										<strong>End: </strong>
								        <input type="text" id="end" value="Carnegie Mellon University"></input>
								        <strong style="display:inline-block;">Mode of Travel: </strong>
								        <div class = "select-wrapper" style="display:inline-block;">
									        <select id="mode" onchange="calcRoute();" class="form-control" style="font-size:12px;width:120px;height:30px;display:inline-block;">
										    	<option value="DRIVING">Driving</option>
										        <option value="WALKING">Walking</option>
										        <option value="BICYCLING">Bicycling</option>
										        <option value="TRANSIT">Transit</option>
										    </select>
								        </div>
								        <a href="#" onclick="popup('popUpDiv')" style="top:0px;right:0px;">Close</a>
								      </div>
								      <div id="map-canvas"></div>
								  </div>
							      <div id="directionsPanel">
							        <p>Total Distance: <span id="total"></span></p>
							      </div>
							    </div>
						    	
							</div>	
                            <div class="col-lg-5 col-sm-5" style="float:right">
                                	<div class="property-rows">
                                		<c:forEach items="${joblist}" var="job" varStatus="status">
                                			<input type="hidden" class="job-position" value="${job.latitude}+${job.longitude}+${job.companyName}+${job.jobTitle}+${job.streetName1}">
                                			<div class="job-content property-row" >
	                                            <div class="row">
	                                            	<div class="property-row-content col-sm-12 col-md-12 col-lg-12" style="padding-left:20px">
	                                                    <h3 class="property-row-title">
	                                                        <a href='${job.jobLink}'>${job.jobTitle}</a>&nbsp;<a href="#"><i id="hi${status.index}" class="fa fa-heart heart" onClick="hello(${status.index})" style="color:#39b54a;font-size:14px"></i></a>
	                                                    	<script>
	                                                    		function hello(i) {
	                                                    			
	                                                    			if($("#hi"+i).css("color")=="rgb(225, 107, 117)") {
	                                                    				$("#hi"+i).css("color","#39b54a");
	                                                    			} else {
	                                                    				$("#hi"+i).css("color","#e16b75");
	                                                    			}
	                                                    			
	                                                    		}
	                                                    	</script>
	                                                    </h3><!-- /.property-row-title -->
	
	                                                    <h4 class="property-row-subtitle">
	                                                        <%-- <a href="#">${job.city}, ${job.state}</a> (${job.latitude}, ${job.longitude}) --%>
	                                                    <a href="#">${job.city}, ${job.state}</a> (${job.distance} miles)
	                                                   
	                                                    </h4><!-- /.property-row-subtitle -->
	
	                                                    <div class="property-row-price">
	                                                    	<a class='company' id='${status.index}' href='#'>${job.companyName}</a>
	                                                    	<c:if test="${job.latitude != '0.0' && job.latitude != ''}">
	                                                        	<a href="#" onclick="popup('popUpDiv', '${job.streetName1}')"><i class="fa fa-map-marker" style="color:#39b54a"></i></a>
	                                                        </c:if>
	                                                    </div><!-- /.property-row-price -->
	                                                    <p class="property-row-body">
	                                                        ${job.jobDescription}… ${job.companyName}
	                                                    </p><!-- /.property-row-body -->
	                                                </div><!-- /.property-row-content -->
	                                            </div><!-- /.row -->
	                                        </div><!-- /.property-row -->
	                                    </c:forEach>
                                        
                                    </div><!-- /.property-rows -->

                                    <!-- <div id="Pagination" class="center">
                                        <ul id="page" class="pagination">
                                            <li><a href="#">&laquo;</a></li>
                                            <li  class="active"><a href="#">1</a></li>
                                            <li><a href="#">2</a></li>
                                            <li><a href="#">3</a></li>
                                            <li><a href="#">4</a></li>
                                            <li><a href="#">5</a></li>
                                            <li><a href="#">&raquo;</a></li>
                                        </ul>
                                    </div> -->
                                    <div class="center">
                                    	<div id="Pagination" class="pagination"></div>
                                    </div>
                                </div>
                        </div><!-- /.block-content-inner -->
                    </div><!-- /.block-content -->
                </div><!-- /.container -->
            </div><!-- /#main-inner -->
        </div><!-- /#main -->
    </div><!-- /#main-wrapper -->
	<div id="footer-wrapper">
        <div id="footer">
            <div id="footer-inner">
                <div class="footer-bottom">
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
                </div><!-- /.footer-bottom -->
            </div><!-- /#footer-inner -->
        </div><!-- /#footer -->
    </div><!-- /#footer-wrapper -->
</div><!-- /#wrapper -->
<script type="text/javascript" src="../assets/js/jquery.cookie.js"></script>
<script type="text/javascript" src="../assets/js/jquery.geocomplete.js"></script>
<script type="text/javascript" src="../assets/libraries/isotope/jquery.isotope.min.js"></script>
<script type="text/javascript" src="../assets/js/gmap3.infobox.js"></script>
<script type="text/javascript" src="../assets/js/gmap3.clusterer.js"></script>
<script type="text/javascript" src="../assets/js/map.js"></script>
<script type="text/javascript" src="../assets/libraries/bootstrap-sass/vendor/assets/javascripts/bootstrap/transition.js"></script>
<script type="text/javascript" src="../assets/libraries/bootstrap-sass/vendor/assets/javascripts/bootstrap/collapse.js"></script>
<script type="text/javascript" src="../assets/libraries/jquery-bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="../assets/libraries/flexslider/jquery.flexslider.js"></script>
<script type="text/javascript" src="../assets/js/jquery.chained.min.js"></script>
<script type="text/javascript" src="../assets/js/realocation.js"></script>
<script type="text/javascript" src="../assets/js/jquery.pagination.js"></script>
<script type="text/javascript" src="../assets/js/mapPop.js"></script>
<script type="text/javascript" src="../assets/js/jobs.js"></script>
<script type="text/javascript" src="../assets/js/test.js" defer></script> 


</body>
</html>