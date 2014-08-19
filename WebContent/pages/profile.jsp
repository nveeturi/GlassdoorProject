<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="shortcut icon" href="assets/img/favicon.ico"  type="image/x-icon" >
    <link rel="stylesheet" type="text/css" href="../assets/libraries/font-awesome/css/font-awesome.css" media="screen, projection">
    <link rel="stylesheet" type="text/css" href="../assets/libraries/jquery-bxslider/jquery.bxslider.css" media="screen, projection">
    <link rel="stylesheet" type="text/css" href="../assets/libraries/flexslider/flexslider.css" media="screen, projection">
    <link rel="stylesheet" type="text/css" href="../assets/css/realocation.css" media="screen, projection" id="css-main">

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
						<li><a href="index/map">Local</a></li>
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
</div><!-- /#header -->    </div><!-- /#header-wrapper -->
<div id="main-wrapper">
    <div id="main">
    <div id="main-inner">
    <div class="container">
    <div class="block-content block-content-small-padding">
    <div class="block-content-inner">
    <div class="row">
    <div class="col-sm-12">
    <h2 class="center">${username}'s Profile</h2>

    <ul class="properties-filter">
    	<li class="selected"><a href="#" data-filter=".property-featured"><span>Featured</span></a></li>
        <li><a href="#" data-filter=".property-rent"><span>Rent</span></a></li>
        <li><a href="#" data-filter=".property-sale"><span>Sale</span></a></li>
    </ul>
    <!-- /.property-filter -->

    <div class="properties-items">
    <div class="row">
    <div class="property-item property-featured col-sm-6 col-md-3">
        <div class="property-box">
            <div class="property-box-inner">
                <h3 class="property-box-title"><a href="#">Fife Ave</a></h3>
                <h4 class="property-box-subtitle"><a href="#">Brooklyn</a></h4>

                <div class="property-box-label property-box-label-primary">Rent</div>
                <!-- /.property-box-label -->

                <div class="property-box-picture">
                    <div class="property-box-price">$ 145 000</div>
                    <!-- /.property-box-price -->
                    <div class="property-box-picture-inner">
                        <a href="#" class="property-box-picture-target">
                            <img src="assets/img/tmp/properties/medium/5.jpg" alt="">
                        </a><!-- /.property-box-picture-target -->
                    </div>
                    <!-- /.property-picture-inner -->
                </div>
                <!-- /.property-picture -->

                <div class="property-box-meta">
                    <div class="property-box-meta-item col-sm-3">
                        <strong>2</strong>
                        <span>Baths</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>1</strong>
                        <span>Beds</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>335</strong>
                        <span>Area</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>1</strong>
                        <span>Garages</span>
                    </div>
                    <!-- /.col-sm-3 -->
                </div>
                <!-- /.property-box-meta -->
            </div>
            <!-- /.property-box-inner -->
        </div>
        <!-- /.property-box -->
    </div>
    <!-- /.property-item -->

    <div class="property-item property-rent col-sm-6 col-md-3">
        <div class="property-box">
            <div class="property-box-inner">
                <h3 class="property-box-title"><a href="#">St Johns Pl</a></h3>
                <h4 class="property-box-subtitle"><a href="#">Palo Alto, SA</a></h4>

                <div class="property-box-picture">
                    <div class="property-box-price">$ 850 / month</div>
                    <!-- /.property-box-price -->
                    <div class="property-box-picture-inner">
                        <a href="#" class="property-box-picture-target">
                            <img src="assets/img/tmp/properties/medium/8.jpg" alt="">
                        </a><!-- /.property-box-picture-target -->
                    </div>
                    <!-- /.property-picture-inner -->
                </div>
                <!-- /.property-picture -->

                <div class="property-box-meta">
                    <div class="property-box-meta-item col-sm-3">
                        <strong>2</strong>
                        <span>Baths</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>2</strong>
                        <span>Beds</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>232</strong>
                        <span>Area</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>2</strong>
                        <span>Garages</span>
                    </div>
                    <!-- /.col-sm-3 -->
                </div>
                <!-- /.property-box-meta -->
            </div>
            <!-- /.property-box-inner -->
        </div>
        <!-- /.property-box -->
    </div>
    <!-- /.property-item -->

    <div class="property-item property-sale col-sm-6 col-md-3">
        <div class="property-box">
            <div class="property-box-inner">
                <h3 class="property-box-title"><a href="#">Culver Blvd</a></h3>
                <h4 class="property-box-subtitle"><a href="#">Civic Betterment</a></h4>

                <div class="property-box-label">Sale</div>
                <!-- /.property-box-label -->

                <div class="property-box-picture">
                    <div class="property-box-price">$ 350 000</div>
                    <!-- /.property-box-price -->
                    <div class="property-box-picture-inner">
                        <a href="#" class="property-box-picture-target">
                            <img src="assets/img/tmp/properties/medium/3.jpg" alt="">
                        </a><!-- /.property-box-picture-target -->
                    </div>
                    <!-- /.property-picture-inner -->
                </div>
                <!-- /.property-picture -->

                <div class="property-box-meta">
                    <div class="property-box-meta-item col-sm-3">
                        <strong>3</strong>
                        <span>Baths</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>2</strong>
                        <span>Beds</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>342</strong>
                        <span>Area</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>3</strong>
                        <span>Garages</span>
                    </div>
                    <!-- /.col-sm-3 -->
                </div>
                <!-- /.property-box-meta -->
            </div>
            <!-- /.property-box-inner -->
        </div>
        <!-- /.property-box -->
    </div>
    <!-- /.property-item -->

    <div class="property-item property-rent col-sm-6 col-md-3">
        <div class="property-box">
            <div class="property-box-inner">
                <h3 class="property-box-title"><a href="#">South St</a></h3>
                <h4 class="property-box-subtitle"><a href="#">Manhattan</a></h4>

                <div class="property-box-picture">
                    <div class="property-box-price">$ 299 000</div>
                    <!-- /.property-box-price -->
                    <div class="property-box-picture-inner">
                        <a href="#" class="property-box-picture-target">
                            <img src="assets/img/tmp/properties/medium/4.jpg" alt="">
                        </a><!-- /.property-box-picture-target -->
                    </div>
                    <!-- /.property-picture-inner -->
                </div>
                <!-- /.property-picture -->

                <div class="property-box-meta">
                    <div class="property-box-meta-item col-sm-3">
                        <strong>3</strong>
                        <span>Baths</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>2</strong>
                        <span>Beds</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>257</strong>
                        <span>Area</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>2</strong>
                        <span>Garages</span>
                    </div>
                    <!-- /.col-sm-3 -->
                </div>
                <!-- /.property-box-meta -->
            </div>
            <!-- /.property-box-inner -->
        </div>
        <!-- /.property-box -->
    </div>
    <!-- /.property-item -->
    </div>
    <!-- /.row -->

    <div class="row">
    <div class="property-item property-featured col-sm-6 col-md-3">
        <div class="property-box">
            <div class="property-box-inner">
                <h3 class="property-box-title"><a href="#">Jeopardy Ln</a></h3>
                <h4 class="property-box-subtitle"><a href="#">Kingman Park</a></h4>

                <div class="property-box-picture">
                    <div class="property-box-price">$ 545 000</div>
                    <!-- /.property-box-price -->
                    <div class="property-box-picture-inner">
                        <a href="#" class="property-box-picture-target">
                            <img src="assets/img/tmp/properties/medium/1.jpg" alt="">
                        </a><!-- /.property-box-picture-target -->
                    </div>
                    <!-- /.property-picture-inner -->
                </div>
                <!-- /.property-picture -->

                <div class="property-box-meta">
                    <div class="property-box-meta-item col-sm-3">
                        <strong>2</strong>
                        <span>Baths</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>1</strong>
                        <span>Beds</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>220</strong>
                        <span>Area</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>1</strong>
                        <span>Garages</span>
                    </div>
                    <!-- /.col-sm-3 -->
                </div>
                <!-- /.property-box-meta -->
            </div>
            <!-- /.property-box-inner -->
        </div>
        <!-- /.property-box -->
    </div>
    <!-- /.property-item -->

    <div class="property-item property-sale col-sm-6 col-md-3">
        <div class="property-box">
            <div class="property-box-inner">
                <h3 class="property-box-title"><a href="#">Jefferson Blvd</a></h3>
                <h4 class="property-box-subtitle"><a href="#">Silicon Valley, SA</a></h4>

                <div class="property-box-label property-box-label-primary">Rent</div>
                <!-- /.property-box-label -->

                <div class="property-box-picture">
                    <div class="property-box-price">$ 430 000</div>
                    <!-- /.property-box-price -->
                    <div class="property-box-picture-inner">
                        <a href="#" class="property-box-picture-target">
                            <img src="assets/img/tmp/properties/medium/11.jpg" alt="">
                        </a><!-- /.property-box-picture-target -->
                    </div>
                    <!-- /.property-picture-inner -->
                </div>
                <!-- /.property-picture -->

                <div class="property-box-meta">
                    <div class="property-box-meta-item col-sm-3">
                        <strong>1</strong>
                        <span>Baths</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>2</strong>
                        <span>Beds</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>266</strong>
                        <span>Area</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>2</strong>
                        <span>Garages</span>
                    </div>
                    <!-- /.col-sm-3 -->
                </div>
                <!-- /.property-box-meta -->
            </div>
            <!-- /.property-box-inner -->
        </div>
        <!-- /.property-box -->
    </div>
    <!-- /.property-item -->

    <div class="property-item property-rent col-sm-6 col-md-3">
        <div class="property-box">
            <div class="property-box-inner">
                <h3 class="property-box-title"><a href="#">McLaugh Ave</a></h3>
                <h4 class="property-box-subtitle"><a href="#">Brooklyn</a></h4>

                <div class="property-box-label property-box-label-primary">Rent</div>
                <!-- /.property-box-label -->

                <div class="property-box-picture">
                    <div class="property-box-price">$ 145 000</div>
                    <!-- /.property-box-price -->
                    <div class="property-box-picture-inner">
                        <a href="#" class="property-box-picture-target">
                            <img src="assets/img/tmp/properties/medium/12.jpg" alt="">
                        </a><!-- /.property-box-picture-target -->
                    </div>
                    <!-- /.property-picture-inner -->
                </div>
                <!-- /.property-picture -->

                <div class="property-box-meta">
                    <div class="property-box-meta-item col-sm-3">
                        <strong>3</strong>
                        <span>Baths</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>3</strong>
                        <span>Beds</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>191</strong>
                        <span>Area</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>2</strong>
                        <span>Garages</span>
                    </div>
                    <!-- /.col-sm-3 -->
                </div>
                <!-- /.property-box-meta -->
            </div>
            <!-- /.property-box-inner -->
        </div>
        <!-- /.property-box -->
    </div>
    <!-- /.property-item -->

    <div class="property-item property-sale col-sm-6 col-md-3">
        <div class="property-box">
            <div class="property-box-inner">
                <h3 class="property-box-title"><a href="#">West Side</a></h3>
                <h4 class="property-box-subtitle"><a href="#">Palo Alto, SA</a></h4>

                <div class="property-box-label">Sale</div>
                <!-- /.property-box-label -->

                <div class="property-box-picture">
                    <div class="property-box-price">$ 430 000</div>
                    <!-- /.property-box-price -->
                    <div class="property-box-picture-inner">
                        <a href="#" class="property-box-picture-target">
                            <img src="assets/img/tmp/properties/medium/6.jpg" alt="">
                        </a><!-- /.property-box-picture-target -->
                    </div>
                    <!-- /.property-picture-inner -->
                </div>
                <!-- /.property-picture -->

                <div class="property-box-meta">
                    <div class="property-box-meta-item col-sm-3">
                        <strong>2</strong>
                        <span>Baths</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>3</strong>
                        <span>Beds</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>211</strong>
                        <span>Area</span>
                    </div>
                    <!-- /.col-sm-3 -->

                    <div class="property-box-meta-item col-sm-3">
                        <strong>2</strong>
                        <span>Garages</span>
                    </div>
                    <!-- /.col-sm-3 -->
                </div>
                <!-- /.property-box-meta -->
            </div>
            <!-- /.property-box-inner -->
        </div>
        <!-- /.property-box -->
    </div>
    <!-- /.property-item -->
    </div>
    <!-- /.row -->

    <div class="row">
        <div class="property-item property-featured col-sm-6 col-md-3">
            <div class="property-box">
                <div class="property-box-inner">
                    <h3 class="property-box-title"><a href="#">Emerson Street</a></h3>
                    <h4 class="property-box-subtitle"><a href="#">Manhattan</a></h4>

                    <div class="property-box-label property-box-label-primary">Rent</div>
                    <!-- /.property-box-label -->

                    <div class="property-box-picture">
                        <div class="property-box-price">$ 299 000</div>
                        <!-- /.property-box-price -->
                        <div class="property-box-picture-inner">
                            <a href="#" class="property-box-picture-target">
                                <img src="assets/img/tmp/properties/medium/7.jpg" alt="">
                            </a><!-- /.property-box-picture-target -->
                        </div>
                        <!-- /.property-picture-inner -->
                    </div>
                    <!-- /.property-picture -->

                    <div class="property-box-meta">
                        <div class="property-box-meta-item col-sm-3">
                            <strong>3</strong>
                            <span>Baths</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>3</strong>
                            <span>Beds</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>300</strong>
                            <span>Area</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>1</strong>
                            <span>Garages</span>
                        </div>
                        <!-- /.col-sm-3 -->
                    </div>
                    <!-- /.property-box-meta -->
                </div>
                <!-- /.property-box-inner -->
            </div>
            <!-- /.property-box -->
        </div>
        <!-- /.property-item -->

        <div class="property-item property-rent col-sm-6 col-md-3">
            <div class="property-box">
                <div class="property-box-inner">
                    <h3 class="property-box-title"><a href="#">Hansbury Ave</a></h3>
                    <h4 class="property-box-subtitle"><a href="#">Civic Betterment</a></h4>

                    <div class="property-box-picture">
                        <div class="property-box-price">$ 2400 / month</div>
                        <!-- /.property-box-price -->
                        <div class="property-box-picture-inner">
                            <a href="#" class="property-box-picture-target">
                                <img src="assets/img/tmp/properties/medium/2.jpg" alt="">
                            </a><!-- /.property-box-picture-target -->
                        </div>
                        <!-- /.property-picture-inner -->
                    </div>
                    <!-- /.property-picture -->

                    <div class="property-box-meta">
                        <div class="property-box-meta-item col-sm-3">
                            <strong>3</strong>
                            <span>Baths</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>3</strong>
                            <span>Beds</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>149</strong>
                            <span>Area</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>2</strong>
                            <span>Garages</span>
                        </div>
                        <!-- /.col-sm-3 -->
                    </div>
                    <!-- /.property-box-meta -->
                </div>
                <!-- /.property-box-inner -->
            </div>
            <!-- /.property-box -->
        </div>
        <!-- /.property-item -->

        <div class="property-item property-sale col-sm-6 col-md-3">
            <div class="property-box">
                <div class="property-box-inner">
                    <h3 class="property-box-title"><a href="#">Everett Ave</a></h3>
                    <h4 class="property-box-subtitle"><a href="#">Kingman Park</a></h4>

                    <div class="property-box-label">Sale</div>
                    <!-- /.property-box-label -->

                    <div class="property-box-picture">
                        <div class="property-box-price">$ 545 000</div>
                        <!-- /.property-box-price -->
                        <div class="property-box-picture-inner">
                            <a href="#" class="property-box-picture-target">
                                <img src="assets/img/tmp/properties/medium/9.jpg" alt="">
                            </a><!-- /.property-box-picture-target -->
                        </div>
                        <!-- /.property-picture-inner -->
                    </div>
                    <!-- /.property-picture -->

                    <div class="property-box-meta">
                        <div class="property-box-meta-item col-sm-3">
                            <strong>1</strong>
                            <span>Baths</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>1</strong>
                            <span>Beds</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>245</strong>
                            <span>Area</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>2</strong>
                            <span>Garages</span>
                        </div>
                        <!-- /.col-sm-3 -->
                    </div>
                    <!-- /.property-box-meta -->
                </div>
                <!-- /.property-box-inner -->
            </div>
            <!-- /.property-box -->
        </div>
        <!-- /.property-item -->

        <div class="property-item property-rent col-sm-6 col-md-3">
            <div class="property-box">
                <div class="property-box-inner">
                    <h3 class="property-box-title"><a href="#">Evergreen Tr</a></h3>
                    <h4 class="property-box-subtitle"><a href="#">Silicon Valley, SA</a></h4>

                    <div class="property-box-picture">
                        <div class="property-box-price">$ 350 000</div>
                        <!-- /.property-box-price -->
                        <div class="property-box-picture-inner">
                            <a href="#" class="property-box-picture-target">
                                <img src="assets/img/tmp/properties/medium/10.jpg" alt="">
                            </a><!-- /.property-box-picture-target -->
                        </div>
                        <!-- /.property-picture-inner -->
                    </div>
                    <!-- /.property-picture -->

                    <div class="property-box-meta">
                        <div class="property-box-meta-item col-sm-3">
                            <strong>3</strong>
                            <span>Baths</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>3</strong>
                            <span>Beds</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>290</strong>
                            <span>Area</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>3</strong>
                            <span>Garages</span>
                        </div>
                        <!-- /.col-sm-3 -->
                    </div>
                    <!-- /.property-box-meta -->
                </div>
                <!-- /.property-box-inner -->
            </div>
            <!-- /.property-box -->
        </div>
        <!-- /.property-item -->
    </div>
    <!-- /.row -->

    <div class="row">
        <div class="property-item property-featured col-sm-6 col-md-3">
            <div class="property-box">
                <div class="property-box-inner">
                    <h3 class="property-box-title"><a href="#">Bedford Ave</a></h3>
                    <h4 class="property-box-subtitle"><a href="#">Brooklyn</a></h4>

                    <div class="property-box-picture">
                        <div class="property-box-price">$ 145 000</div>
                        <!-- /.property-box-price -->
                        <div class="property-box-picture-inner">
                            <a href="#" class="property-box-picture-target">
                                <img src="assets/img/tmp/properties/medium/1.jpg" alt="">
                            </a><!-- /.property-box-picture-target -->
                        </div>
                        <!-- /.property-picture-inner -->
                    </div>
                    <!-- /.property-picture -->

                    <div class="property-box-meta">
                        <div class="property-box-meta-item col-sm-3">
                            <strong>3</strong>
                            <span>Baths</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>1</strong>
                            <span>Beds</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>151</strong>
                            <span>Area</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>1</strong>
                            <span>Garages</span>
                        </div>
                        <!-- /.col-sm-3 -->
                    </div>
                    <!-- /.property-box-meta -->
                </div>
                <!-- /.property-box-inner -->
            </div>
            <!-- /.property-box -->
        </div>
        <!-- /.property-item -->

        <div class="property-item property-sale col-sm-6 col-md-3">
            <div class="property-box">
                <div class="property-box-inner">
                    <h3 class="property-box-title"><a href="#">McLaugh Ave</a></h3>
                    <h4 class="property-box-subtitle"><a href="#">Civic Betterment</a></h4>

                    <div class="property-box-label property-box-label-primary">Rent</div>
                    <!-- /.property-box-label -->

                    <div class="property-box-picture">
                        <div class="property-box-price">$ 299 000</div>
                        <!-- /.property-box-price -->
                        <div class="property-box-picture-inner">
                            <a href="#" class="property-box-picture-target">
                                <img src="assets/img/tmp/properties/medium/2.jpg" alt="">
                            </a><!-- /.property-box-picture-target -->
                        </div>
                        <!-- /.property-picture-inner -->
                    </div>
                    <!-- /.property-picture -->

                    <div class="property-box-meta">
                        <div class="property-box-meta-item col-sm-3">
                            <strong>2</strong>
                            <span>Baths</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>1</strong>
                            <span>Beds</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>172</strong>
                            <span>Area</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>2</strong>
                            <span>Garages</span>
                        </div>
                        <!-- /.col-sm-3 -->
                    </div>
                    <!-- /.property-box-meta -->
                </div>
                <!-- /.property-box-inner -->
            </div>
            <!-- /.property-box -->
        </div>
        <!-- /.property-item -->

        <div class="property-item property-rent col-sm-6 col-md-3">
            <div class="property-box">
                <div class="property-box-inner">
                    <h3 class="property-box-title"><a href="#">Fife Ave</a></h3>
                    <h4 class="property-box-subtitle"><a href="#">Kingman Park</a></h4>

                    <div class="property-box-label property-box-label-primary">Rent</div>
                    <!-- /.property-box-label -->

                    <div class="property-box-picture">
                        <div class="property-box-price">$ 430 000</div>
                        <!-- /.property-box-price -->
                        <div class="property-box-picture-inner">
                            <a href="#" class="property-box-picture-target">
                                <img src="assets/img/tmp/properties/medium/7.jpg" alt="">
                            </a><!-- /.property-box-picture-target -->
                        </div>
                        <!-- /.property-picture-inner -->
                    </div>
                    <!-- /.property-picture -->

                    <div class="property-box-meta">
                        <div class="property-box-meta-item col-sm-3">
                            <strong>2</strong>
                            <span>Baths</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>3</strong>
                            <span>Beds</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>285</strong>
                            <span>Area</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>2</strong>
                            <span>Garages</span>
                        </div>
                        <!-- /.col-sm-3 -->
                    </div>
                    <!-- /.property-box-meta -->
                </div>
                <!-- /.property-box-inner -->
            </div>
            <!-- /.property-box -->
        </div>
        <!-- /.property-item -->

        <div class="property-item property-sale col-sm-6 col-md-3">
            <div class="property-box">
                <div class="property-box-inner">
                    <h3 class="property-box-title"><a href="#">Jefferson Blvd</a></h3>
                    <h4 class="property-box-subtitle"><a href="#">Silicon Valley, SA</a></h4>

                    <div class="property-box-label">Sale</div>
                    <!-- /.property-box-label -->

                    <div class="property-box-picture">
                        <div class="property-box-price">$ 299 000</div>
                        <!-- /.property-box-price -->
                        <div class="property-box-picture-inner">
                            <a href="#" class="property-box-picture-target">
                                <img src="assets/img/tmp/properties/medium/10.jpg" alt="">
                            </a><!-- /.property-box-picture-target -->
                        </div>
                        <!-- /.property-picture-inner -->
                    </div>
                    <!-- /.property-picture -->

                    <div class="property-box-meta">
                        <div class="property-box-meta-item col-sm-3">
                            <strong>2</strong>
                            <span>Baths</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>1</strong>
                            <span>Beds</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>327</strong>
                            <span>Area</span>
                        </div>
                        <!-- /.col-sm-3 -->

                        <div class="property-box-meta-item col-sm-3">
                            <strong>3</strong>
                            <span>Garages</span>
                        </div>
                        <!-- /.col-sm-3 -->
                    </div>
                    <!-- /.property-box-meta -->
                </div>
                <!-- /.property-box-inner -->
            </div>
            <!-- /.property-box -->
        </div>
        <!-- /.property-item -->
    </div>
    <!-- /.row -->
    </div>
    <!-- /.properties-items -->

    </div>
    </div>
    <!-- /.row -->
    </div>
    <!-- /.block-content-inner -->
    </div>
    <!-- /.block-content -->
    </div>
    <!-- /.container -->
    </div>
    <!-- /#main-inner -->
    </div>
    <!-- /#main -->
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

<script type="text/javascript" src="../assets/js/jquery.js"></script>
<script type="text/javascript" src="../assets/libraries/isotope/jquery.isotope.min.js"></script>

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?v=3&amp;sensor=true"></script>
<script type="text/javascript" src="../assets/js/gmap3.infobox.js"></script>
<script type="text/javascript" src="../assets/js/gmap3.clusterer.js"></script>
<script type="text/javascript" src="../assets/js/map.js"></script>

<script type="text/javascript" src="../assets/libraries/bootstrap-sass/vendor/assets/javascripts/bootstrap/transition.js"></script>
<script type="text/javascript" src="../assets/libraries/bootstrap-sass/vendor/assets/javascripts/bootstrap/collapse.js"></script>
<script type="text/javascript" src="../assets/libraries/jquery-bxslider/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="../assets/libraries/flexslider/jquery.flexslider.js"></script>
<script type="text/javascript" src="../assets/js/jquery.chained.min.js"></script>
<script type="text/javascript" src="../assets/js/realocation.js"></script>

</body>
</html>