<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="shortcut icon" href="favicon.ico">
<link
	href='http://fonts.googleapis.com/css?family=Lato:300,400,300italic,400italic'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Montserrat:400,700'
	rel='stylesheet' type='text/css'>
<!-- Global CSS -->
<link rel="stylesheet"
	href="assets/plugins/bootstrap/css/bootstrap.min.css">
<!-- Plugins CSS -->
<link rel="stylesheet" href="assets/plugins/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="assets/plugins/animate-css/animate.min.css">
<!-- Theme CSS -->
<link id="theme-style" rel="stylesheet" href="assets/css/styles.css">
<link id="theme-style" rel="stylesheet" href="assets/css/login.css">
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
							<li class="nav-item"><a href="index/jobs">Jobs</a></li>
							<li class="nav-item"><a href="tour.html">Companies</a></li>
							<li class="nav-item"><a href="pricing.html">Salaries</a></li>
							<li class="nav-item"><a href="blog.html">Interviews</a></li>
							<li class="nav-item"><a href="map.html">Map</a></li>
							<li class="nav-item nav-item-cta last">
								<button id='modal-launcher' class="btn" data-toggle="modal" data-target="#login-modal">Login</button>
							</li>
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

		<!-- ******PROMO****** -->
		<section id="promo" class="promo section">
			<div class="container intro">
				<h2 class="title">Get Hired. Love Your Job.</h2>
				<p class="summary">Brand new Map job matching function enables easier job hunting</p>
			</div>
			<!--//intro-->

			<div class="signup">
				<div class="container text-center">
					<form class="signup-form" action="index/search" method="post">
						&nbsp;&nbsp;&nbsp;
						<div class="row">
						  <div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
						    <div class="form-group">
						      <input type="text" name="keyword" class="form-control" placeholder="Job Title, Keywords, or Company">
						    </div><!-- /input-group -->
						  </div><!-- /.col-lg-4 -->
				
						  <div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
						    <div class="form-group">
						      <input type="text" name="location" class="form-control" placeholder="Location">
						    </div><!-- /input-group -->
						  </div><!-- /.col-lg-4 -->
						  
						  <div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
						  	<div class="col-lg-4 btn-group">
						  		<button type="submit" class="btn btn-cta btn-cta-primary">Search</button>
						  	</div>
						  	<div class="col-lg-8 btn-group">
						  		<button type="submit" class="btn btn-cta btn-cta-primary">Show Nearby Jobs</button>
						  	</div>
						  </div><!-- /.col-lg-4 -->
						  
						  </div><!-- /.row -->
					</form>
					<!--//signup-form-->	
					
					
							
				</div>
				<!--//contianer-->
				<br /> <br />

				<div class="container">
					<h3 class="title text-center">Job Catetory</h3>
					<br />
					<div class="col-lg-4">
						<div class="recommand">
							<ul class="list-unstyled" style="padding-left: 10px;">
								<li class="link"><a href="#"><i class="fa fa-caret-right">&nbsp;</i>IT</a></li>
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Human Resource</a></li>
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Healthcare</a></li>
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Education</a></li>
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Finance</a></li>
							</ul>
						</div>
					</div>
					
					<div class="col-lg-4">
						<div class="recommand">
							<ul class="list-unstyled" style="padding-left: 10px">
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Customer Service</a></li>
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Sales</a></li>
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Warehouse</a></li>
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Accounting</a></li>
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Construction</a></li>
							</ul>
						</div>
					</div>
					
					<div class="col-lg-4">
						<div class="recommand">
							<ul class="list-unstyled" style="padding-left: 10px">
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Data Entry</a></li>
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Insurance</a></li>
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Driver</a></li>
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Maintenance</a></li>
								<li><a href="#"><i class="fa fa-caret-right">&nbsp;</i>Nursing</a></li>
							</ul>
						</div>
					</div>
				</div>
				<!--//recommand-->			
			</div>
			<!--//signup-->		
		</section>
		<!--//promo-->


		<!-- ******WHY****** -->
		<section id="why" class="why section">
			<div class="container">
				<h2 class="title text-center"><span ><a href="#why"><i class="glyphicon glyphicon-bullhorn"></i></a></span></h2>
				<h2 class="title text-center">See What Employees Are Saying</h2>
				<p class="intro text-center">all posted anonymously by employees and job seekers</p>
				
				<ul class="nav nav-tabs" role="tablist">
				  <li class="active"><a href="#CompanyReviews" role="tab" data-toggle="tab">Company Reviews</a></li>
				  <li><a href="#Salaries" role="tab" data-toggle="tab">Salaries</a></li>
				  <li><a href="#Interviews" role="tab" data-toggle="tab">Interviews</a></li>
				</ul>
				
				<div class="tab-content">
					<div class="tab-pane active" id = "CompanyReviews">
						<div class="testimonials row col-lg-8">
							
							<div class="item col-lg-6">
								<div class="quote-box">
									<blockquote class="quote">
									<div class="row">
										<div class="col-lg-3"><img class="img-responsive" src="assets/images/companies/expedia.png" alt=""/></div>
										<div class="col-lg-9 title">Expedia</div>
									</div>
									<a href="#">Excellent work environment and opportunity for GLOBAL advancement!</a><br/>
									<b>Pros - </b>Training was comprehensive; excellent pay and benefits; many different opportunity areas for advancement. If you are...
									</blockquote>
									<!--//quote-->
									<p class="details">
										<span class="name">Sales Agent</span> <span class="title">reviewed 16 days ago</span>
									</p>
									<i class="fa fa-quote-right"></i>
								</div>
								<!--//quote-box-->
							</div>
							<!--//item-->
							
							<div class="item col-lg-6">
								<div class="quote-box">
									<blockquote class="quote">
									<div class="row">
										<div class="col-lg-3"><img class="img-responsive" src="assets/images/companies/morgan-stanley.png" alt=""/></div>
										<div class="title">Morgan Stanley</div>
									</div>
									<a href="#">decent place to work</a><br/>
									<b>Pros - </b>good experience for someone starting out in their career
									</blockquote>
									<!--//quote-->
									<p class="details">
										<span class="name">Employee</span> <span class="title">reviewed 12 days ago</span>
									</p>
									<i class="fa fa-quote-right"></i>
								</div>
								<!--//quote-box-->
							</div>
							<!--//item-->
							 
						</div>
						
						<div class="testimonials row col-lg-8">
							
							<div class="item col-lg-6">
								<div class="quote-box">
									<blockquote class="quote">
									<div class="row">
										<div class="col-lg-3"><img class="img-responsive" src="assets/images/companies/juniper.png" alt=""/></div>
										<div class="col-lg-9 title">Juniper Networks</div>
									</div>
									<a href="#">Great company, but stop the layoffs!!</a><br/>
									<b>Pros - </b>Good company.. Good technology. Higher leadership team is doing a great job. The new CEO knows what hes doing. Great...
									</blockquote>
									<!--//quote-->
									<p class="details">
										<span class="name">Hardware Engineer</span> <span class="title">reviewed 19 days ago</span>
									</p>
									<i class="fa fa-quote-right"></i>
								</div>
								<!--//quote-box-->
							</div>
							<!--//item-->
							
							<div class="item col-lg-6">
								<div class="quote-box">
									<blockquote class="quote">
									<div class="row">
										<div class="col-lg-3"><img class="img-responsive" src="assets/images/companies/vmware.png" alt=""/></div>
										<div class="title">VMware</div>
									</div>
									<a href="#">Human Resources</a><br/>
									<b>Pros - </b>Great team and work/life balance! Competitive compensation.
									</blockquote>
									<!--//quote-->
									<p class="details">
										<span class="name">Employee</span> <span class="title">reviewed 2 days ago</span>
									</p>
									<i class="fa fa-quote-right"></i>
								</div>
								<!--//quote-box-->
							</div>
							<!--//item-->
						</div>
					</div>
					
					<div class = "row tab-pane" id = "Salaries">
					<div class="benefits col-lg-8">
						<div class="item clearfix">
							<div class="panel panel-default">
								<div class="panel-body row">
									<div class="col-lg-1"><img class="img-responsive" src="assets/images/companies/ibm.png" alt=""/></div>
									<div class="col-lg-9"><a href="#">IBM Advisory Software Engineer</a></div>
								  	<div class="col-lg-2" style="text-align:right">$109,000</div>
								</div>
							</div>
							<div class="panel panel-default">
								<div class="panel-body row">
									<div class="col-lg-10"><a href="#">GE Engineer</a></div>
								  	<div class="col-lg-2" style="text-align:right">$69,000</div>
								</div>
							</div>
							<div class="panel panel-default">
								<div class="panel-body row">
									<div class="col-lg-10"><a href="#">KPMG Audit Associate</a></div>
								  	<div class="col-lg-2" style="text-align:right">$54,000</div>
								</div>
							</div>
							<div class="panel panel-default">
								<div class="panel-body row">
									<div class="col-lg-10"><a href="#">Exxon Mobil Engineer</a></div>
								  	<div class="col-lg-2" style="text-align:right">$97,000</div>
								</div>
							</div>
							<div class="panel panel-default">
								<div class="panel-body row">
									<div class="col-lg-10"><a href="#">Capgemini Manager</a></div>
								  	<div class="col-lg-2" style="text-align:right">$121,000</div>
								</div>
							</div>
							<div class="panel panel-default">
								<div class="panel-body row">
									<div class="col-lg-10"><a href="#">Expedia Program Manager</a></div>
								  	<div class="col-lg-2" style="text-align:right">$91,000</div>
								</div>
							</div>
						</div>
					</div>
					</div>
				
					<div class = "row tab-pane" id = "Interviews">
						<div class="benefits col-lg-8">
							<div class="item clearfix">
								<div class="icon col-lg-2">
									<img class="img-responsive" src="assets/images/companies/google.png" alt=""/>
								</div>
								<!--//icon-->
								<div class="content col-lg-6">
									<h3 class="title">Interviewing at Google</h3>
									<p class="desc">
										A classic Google process - two phone interviews, then five 1:1 on-site interviews...
										<a href="#">Read Interview</a>
									</p>
								</div>
								<div class="content col-lg-4">
									<p class="desc">
										<b>Interview Question:</b><br/>
										All questions were from the expected area.<br/>
										<a href="#">Answer This Question</a>
									</p>
								</div>
								<!--//content-->
							</div>
							<!--//item-->
							<div class="item clearfix">
								<div class="icon col-lg-2">
									<img class="img-responsive" src="assets/images/companies/pnc.png" alt=""/>
								</div>
								<!--//icon-->
								<div class="content col-lg-6">
									<h3 class="title">Interviewing at PNC Financial Services Group</h3>
									<p class="desc">
										Five interviews. Hiring and interview process was fairly easy. Very conversational...
										<a href="#">Read Interview</a>
									</p>
								</div>
								<div class="content col-lg-4">
									<p class="desc">
										<b>Interview Question:</b><br/>
										No difficult or unexpected question.<br/>
										<a href="#">Answer This Question</a>
									</p>
								</div>
								<!--//content-->
							</div>
							<!--//item-->
							<div class="item clearfix">
								<div class="icon col-lg-2">
									<img class="img-responsive" src="assets/images/companies/emc.png" alt=""/>
								</div>
								<!--//icon-->
								<div class="content col-lg-6">
									<h3 class="title">Interviewing at EMC</h3>
									<p class="desc">
										I was initially contacted by a third-party recruiter. He found my resume and profile...
										<a href="#">Read Interview</a>
									</p>
								</div>
								<div class="content col-lg-4">
									<p class="desc">
										<b>Interview Question:</b><br/>
										I was handed a piece of paper with three...<br/>
										<a href="#">Answer This Question</a>
									</p>
								</div>
								<!--//content-->
							</div>
							<!--//item-->	
					</div>
				<!--//row-->
				</div>
			</div>
			<!--//container-->
		</section>
		<!--//why-->

		

	</div>
	<!--//wrapper-->

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


	<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body login-modal">
					<div class="clearfix"></div>
					<div id='social-icons-conatainer'>
						<div class='modal-body-left'>
							<div class="form-group">
								<input type="text" id="username" placeholder="Enter your name"
									value="" class="form-control login-field"> <i
									class="fa fa-user login-field-icon"></i>
							</div>

							<div class="form-group">
								<input type="password" id="login-pass" placeholder="Password"
									value="" class="form-control login-field"> <i
									class="fa fa-lock login-field-icon"></i>
							</div>
							
							<div class="row">
								<div class="icon col-lg-5"><a href="#" class="btn btn-success modal-login-btn">Login</a></div>
								<div class="icon col-lg-7"><a href="#" class="btn modal-login-btn text-center">Lost your password?</a></div>
							</div>

							
						</div>

						<div class='modal-body-right'>
							<div class="modal-social-icons">
								<a href='#' class="btn btn-default facebook"> <i
									class="fa fa-facebook modal-icons"></i> Sign In with Facebook
								</a> <a href='#' class="btn btn-default twitter"> <i
									class="fa fa-twitter modal-icons"></i> Sign In with Twitter
								</a> <a href='#' class="btn btn-default google"> <i
									class="fa fa-google-plus modal-icons"></i> Sign In with Google
								</a> <a href='#' class="btn btn-default linkedin"> <i
									class="fa fa-linkedin modal-icons"></i> Sign In with Linkedin
								</a>
							</div>
						</div>
						<div id='center-line'></div>
					</div>
					<div class="clearfix"></div>

					<div class="form-group modal-register-btn">
						<button class="btn btn-default">New User Please Register</button>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	



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
	<!-- <script type="text/javascript" src="assets/js/modernizr-2.6.2.min.js"></script> -->
	<!--[if !IE]>-->
	<script type="text/javascript" src="assets/js/animations.js"></script>
	<!--<![endif]-->
</body>
</html>


