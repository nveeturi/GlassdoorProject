// get height of the window 
function getClientHeight() {   
    var clientHeight = 0;   
    if(document.body.clientHeight&&document.documentElement.clientHeight){   
        clientHeight=(document.body.clientHeight<document.documentElement.clientHeight)?document.body.clientHeight:document.documentElement.clientHeight;           
    }else{   
        clientHeight=(document.body.clientHeight>document.documentElement.clientHeight)?document.body.clientHeight:document.documentElement.clientHeight;       
    }   
    return clientHeight;   
}

// get height of the content
function getScrollHeight() {    
    return Math.max(document.body.scrollHeight,document.documentElement.scrollHeight);   
}

// get the height of the top with scroll
function getScrollTop(){   
    var scrollTop=0;   
    if(document.documentElement&&document.documentElement.scrollTop){   
        scrollTop=document.documentElement.scrollTop;   
    }else if(document.body){   
        scrollTop=document.body.scrollTop;   
    }   
    return scrollTop;   
}

function fixDiv(div_id,offsetTop){
	var offsetTop=arguments[1]?arguments[1]:0;
	var Obj=$('#'+div_id);
    
	$(window).scroll(function(){
		var height = getClientHeight();
		var contentHeight = getScrollHeight();
		var h = contentHeight - 200 - height;
		
    	if($(window).scrollTop() >= 0 && $(window).scrollTop() < h) {
    		Obj.css({
                'position':'fixed',
                'top':0+offsetTop+'px',
				'z-index':1
            });
    	} else if($(window).scrollTop() >= h){
			Obj.css({
				'position':'relative',
	    		'top':h
	    	});
    	} else {
    		Obj.css({
				'position':'relative',
	    		'top':0
	    	});
    	}
    });
}

var locations = [];
var contents = [];
var types = [];
var images = [];
var latitudes = [];
var longitudes = [];
var companyNames = [];
var jobTitles = [];
var streetNames = [];
var jobResults = [];
var map;
var markers = [];

var hash = {};


function pageselectCallback(page_id, jq) {
	var pageSize = 10;
	locations = [];
	contents = [];
	types = [];
	images = [];
	hash = {};
	
	deleteMarkers();
	
	navigator.geolocation.getCurrentPosition(function(position) {
		var markerOptions = {};
	    markerOptions.position = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
	    markerOptions.map = map;
	    
	    var marker = new google.maps.Marker(markerOptions); 
		var infowindow = new google.maps.InfoWindow({
            content: 'You are here!'
        });
		marker.setIcon("../assets/img/icons/marker_red.png");
    	infowindow.open(map,marker);
	});
	$(".job-content").hide();
	$(".job-content").each(function(n) {
    	if (n >= pageSize * page_id && n < pageSize * (page_id + 1)) {
        	$(this).show();
        	if(latitudes[n] != '0.0' && latitudes[n] != '' && hash[latitudes[n]+','+longitudes[n]] == undefined) {
//        		alert(latitudes[n]+','+longitudes[n]+','+companyNames[n]+','+jobTitles[n]+','+streetNames[n]);
        		var jobResult = {};
            	jobResult.latitude = latitudes[n];
            	jobResult.longitude = longitudes[n];
            	jobResult.companyName = companyNames[n];
            	jobResult.jobTitle = jobTitles[n];
            	jobResult.streetName = streetNames[n];
            	jobResults.push(jobResult);
//            	locations.push(Array(latitudes[n], longitudes[n]));
//            	contents.push('<div class="infobox"><div class="infobox-header"><h3 class="infobox-title"><a href="#">'+jobTitles[n]+'</a></h3></div><div class="infobox-picture"><div class="infobox-price">'+companyNames[n]+'</div></div></div>');
//                types.push('apartment');
//                images.push('<img src="../assets/img/icons/flatblocks2.png" alt="">');
            	showJob(jobResult);
//            	addMarker(jobResult);
            	hash[latitudes[n]+','+longitudes[n]] = companyNames[n];
        	}
        }  
    });
	
	$('.company').hover(
    	function() {
    		var i = parseInt(this.id) % 10;
    		markers[i].setIcon("../assets/img/icons/marker_orange.png");
    	}, function() {
    		var i = parseInt(this.id) % 10;
    		markers[i].setIcon("../assets/img/icons/marker_green.png");
    	}
    );

}

function showJob(jobResult) {
	var markerOptions = {};
    markerOptions.position = new google.maps.LatLng(jobResult.latitude, jobResult.longitude);
    markerOptions.map = map;
    
    var marker = new google.maps.Marker(markerOptions); 
    marker.setAnimation(google.maps.Animation.BOUNCE);
    setTimeout(function(){marker.setAnimation(null);}, 1000);
    
    marker.setIcon("../assets/img/icons/marker_green.png");
    jobResult.marker = marker;
    jobResult.infowindow = new google.maps.InfoWindow({
    	content:'<div class="infobox"><div class="infobox-header"><h3 class="infobox-title"><a href="#">'+jobResult.jobTitle+'</a></h3></div><div class="infobox-picture"><div class="infobox-price">'+jobResult.companyName+'</div></div></div>'
    });
    google.maps.event.addListener(jobResult.marker, 'mouseover', function(){
    	jobResult.infowindow.open(map,jobResult.marker);
    });
    google.maps.event.addListener(jobResult.marker, 'mouseout', function(){
    	jobResult.infowindow.close();
    });
    
    markers.push(marker);
}

function addMarker(jobResult) {
	var markerOptions = {};
    markerOptions.position = new google.maps.LatLng(jobResult.latitude, jobResult.longitude);
    markerOptions.map = map;
    
    var marker = new google.maps.Marker(markerOptions); 
    marker.setAnimation(google.maps.Animation.BOUNCE);
    
    jobResult.marker = marker;
    jobResult.infowindow = new google.maps.InfoWindow({
    	content:'<div class="infobox"><div class="infobox-header"><h3 class="infobox-title"><a href="#">'+jobResult.jobTitle+'</a></h3></div><div class="infobox-picture"><div class="infobox-price">'+jobResult.companyName+'</div></div></div>'
    });
    google.maps.event.addListener(jobResult.marker, 'mouseover', function(){
    	jobResult.infowindow.open(map,jobResult.marker);
    });
    google.maps.event.addListener(jobResult.marker, 'mouseout', function(){
    	jobResult.infowindow.close();
    });	
}

function setAllMap(map) {
	for (var i = 0; i < markers.length; i++) {
		markers[i].setMap(map);
	 }
}

function clearMarkers() {
	setAllMap(null);
}

function deleteMarkers() {
	clearMarkers();
	markers = [];
}

function toggle(div_id) {
	var el = document.getElementById(div_id);
	if ( el.style.display == 'none' ) {	el.style.display = 'block';}
	else {el.style.display = 'none';}
}

function blanket_size(popUpDivVar) {
	if (typeof window.innerWidth != 'undefined') {
		viewportheight = window.innerHeight;
	} else {
		viewportheight = document.documentElement.clientHeight;
	}
	if ((viewportheight > document.body.parentNode.scrollHeight) && (viewportheight > document.body.parentNode.clientHeight)) {
		blanket_height = viewportheight;
	} else {
		if (document.body.parentNode.clientHeight > document.body.parentNode.scrollHeight) {
			blanket_height = document.body.parentNode.clientHeight;
		} else {
			blanket_height = document.body.parentNode.scrollHeight;
		}
	}
	var blanket = document.getElementById('blanket');
	blanket.style.height = blanket_height + 'px';
	var popUpDiv = document.getElementById(popUpDivVar);
	popUpDiv_height=blanket_height/2-200;//200 is half popup's height
	popUpDiv.style.top = popUpDiv_height + 'px';
}

function window_pos(popUpDivVar) {
	if (typeof window.innerWidth != 'undefined') {
		viewportwidth = window.innerHeight;
	} else {
		viewportwidth = document.documentElement.clientHeight;
	}
	if ((viewportwidth > document.body.parentNode.scrollWidth) && (viewportwidth > document.body.parentNode.clientWidth)) {
		window_width = viewportwidth;
	} else {
		if (document.body.parentNode.clientWidth > document.body.parentNode.scrollWidth) {
			window_width = document.body.parentNode.clientWidth;
		} else {
			window_width = document.body.parentNode.scrollWidth;
		}
	}
	var popUpDiv = document.getElementById(popUpDivVar);
	window_width=window_width/2-400;//200 is half popup's width
	popUpDiv.style.left = window_width + 'px';
}

function popup(windowname, streetname) {

	$('#end').val(streetname+',Pittsburgh, PA');
	window_pos(windowname);
	
	toggle('blanket');
	toggle(windowname);	
	
	placeInitialize();
	mapInitialize();	
	
	
}


(function ($) {
	fixDiv('show',200);
	fixDiv('refinesearch',200);
	
	var jobs = document.getElementsByClassName("job-position");
	
	Array.prototype.forEach.call(jobs, function(job) {
		var splitted = job.value.split("+");
		latitudes.push(splitted[0]);
		longitudes.push(splitted[1]);
		companyNames.push(splitted[2]);
		jobTitles.push(splitted[3]);
		streetNames.push(splitted[4]);
	});
	
	map = new google.maps.Map(document.getElementById("jobmap"), {
        mapTypeId: google.maps.MapTypeId.ROADMAP, 
        zoom: 12, 
        center: new google.maps.LatLng(40.44, -80.00),
        styles : [{"featureType":"water","elementType":"geometry","stylers":[{"color":"#a2daf2"}]},{"featureType":"landscape.man_made","elementType":"geometry","stylers":[{"color":"#f7f1df"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#d0e3b4"}]},{"featureType":"landscape.natural.terrain","elementType":"geometry","stylers":[{"visibility":"off"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#bde6ab"}]},{"featureType":"poi","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"poi.medical","elementType":"geometry","stylers":[{"color":"#fbd3da"}]},{"featureType":"poi.business","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#ffe15f"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#efd151"}]},{"featureType":"road.arterial","elementType":"geometry.fill","stylers":[{"color":"#ffffff"}]},{"featureType":"road.local","elementType":"geometry.fill","stylers":[{"color":"black"}]},{"featureType":"transit.station.airport","elementType":"geometry.fill","stylers":[{"color":"#cfb2db"}]}],
    });
	
	$("#Pagination").pagination(parseInt(totalnum), {
		callback : pageselectCallback,
		prev_text : '< Prev', 
  		next_text: 'Next >',
		items_per_page : 10,
		num_display_entries : 6,
		current_page : 0,
		num_edge_entries : 1
	});
	
	var sortValue = $.cookie('sort');
	$('#sort-by').val(sortValue);

	
	$('#sort-by').change(function() {
		$.cookie('sort', $(this).val(), {expires: 365});
		$("#sort-by").val($(this).val());
	});
	
	
	var filterDistanceValue = $.cookie('filter-distance');
	$('#filter-distance').val(filterDistanceValue);
	
	$('#filter-distance').change(function() {
		$.cookie('filter-distance', $(this).val(), {expires: 365});
		$("#filter-distance").val($(this).val());
	});
	
	var filterTimeValue = $.cookie('filter-time');
	$('#filter-time').val(filterTimeValue);
	
	$('#filter-time').change(function() {
		$.cookie('filter-time', $(this).val(), {expires: 365});
		$("#filter-time").val($(this).val());
	});
	
	
	var filterTypeValue = $.cookie('filter-type');
	$('#filter-type').val(filterTypeValue);
	
	$('#filter-type').change(function() {
		$.cookie('filter-type', $(this).val(), {expires: 365});
		$("#filter-type").val($(this).val());
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	map = $('#jobmap').aviators_map({
//        locations: locations,
//        contents: contents,
//        types: types,
//        images: images,
//        transparentMarkerImage: '../assets/img/marker-transparent.png',
//        transparentClusterImage: '../assets/img/clusterer-transparent.png',
//        zoom: 13,
//        center: {
//            latitude: 37.77,
//            longitude: -122.42
//        },
//        enableGeolocation: false,
//        styles: [{"featureType":"water","elementType":"geometry","stylers":[{"color":"#a2daf2"}]},{"featureType":"landscape.man_made","elementType":"geometry","stylers":[{"color":"#f7f1df"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#d0e3b4"}]},{"featureType":"landscape.natural.terrain","elementType":"geometry","stylers":[{"visibility":"off"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#bde6ab"}]},{"featureType":"poi","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"poi.medical","elementType":"geometry","stylers":[{"color":"#fbd3da"}]},{"featureType":"poi.business","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#ffe15f"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#efd151"}]},{"featureType":"road.arterial","elementType":"geometry.fill","stylers":[{"color":"#ffffff"}]},{"featureType":"road.local","elementType":"geometry.fill","stylers":[{"color":"black"}]},{"featureType":"transit.station.airport","elementType":"geometry.fill","stylers":[{"color":"#cfb2db"}]}],
//        pixelOffsetX     : -100,
//		pixelOffsetY     : -155
//	});
		
})(jQuery);

