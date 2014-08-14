// get height of the window 
function getClientHeight() {   
    var clientHeight=0;   
    if(document.body.clientHeight&&document.documentElement.clientHeight){   
        var clientHeight=(document.body.clientHeight<document.documentElement.clientHeight)?document.body.clientHeight:document.documentElement.clientHeight;           
    }else{   
        var clientHeight=(document.body.clientHeight>document.documentElement.clientHeight)?document.body.clientHeight:document.documentElement.clientHeight;       
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
    	if($(window).scrollTop() >= 0 && $(window).scrollTop() < 1475) {
    		Obj.css({
                'position':'fixed',
                'top':0+offsetTop+'px',
				'z-index':1
            });
    	} else if($(window).scrollTop() >= 1350){
			Obj.css({
				'position':'relative',
	    		'top':1350
	    	});
    	} else {
    		Obj.css({
				'position':'relative',
	    		'top':0
	    	});
    	}
    });
}

function pageselectCallback(page_id, jq) {
	var pageSize = 10;
	$(".job-content").hide();
    $(".job-content").each(function(n) {
        if (n >= pageSize * page_id && n < pageSize * (page_id + 1))
            $(this).show();
    });
}


(function ($) {
	fixDiv('show',200);
	fixDiv('refinesearch',200);
	
	$("#Pagination").pagination(parseInt(totalnum), {
		callback : pageselectCallback,
		prev_text : '< Prev', 
  		next_text: 'Next >',
		items_per_page : 10,
		num_display_entries : 6,
		current_page : 0,
		num_edge_entries : 1
	});
	
	var map = new google.maps.Map(document.getElementById("jobmap"), {
        mapTypeId: google.maps.MapTypeId.ROADMAP, 
        zoom: 10, 
        center: new google.maps.LatLng(37.77,-122.42),
        styles : [{"featureType":"water","elementType":"geometry","stylers":[{"color":"#a2daf2"}]},{"featureType":"landscape.man_made","elementType":"geometry","stylers":[{"color":"#f7f1df"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#d0e3b4"}]},{"featureType":"landscape.natural.terrain","elementType":"geometry","stylers":[{"visibility":"off"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#bde6ab"}]},{"featureType":"poi","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"poi.medical","elementType":"geometry","stylers":[{"color":"#fbd3da"}]},{"featureType":"poi.business","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#ffe15f"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#efd151"}]},{"featureType":"road.arterial","elementType":"geometry.fill","stylers":[{"color":"#ffffff"}]},{"featureType":"road.local","elementType":"geometry.fill","stylers":[{"color":"black"}]},{"featureType":"transit.station.airport","elementType":"geometry.fill","stylers":[{"color":"#cfb2db"}]}],
    });
	
	for (var i=0;i<cities.length; i++) {
        (function(){
            var city, markerOptions;
            city = cities[i];
            markerOptions = {};
            markerOptions.position = new google.maps.LatLng(city.lat, city.lng);
            markerOptions.map = map;
            
            city.marker = new google.maps.Marker(markerOptions);
//          city.marker.setIcon("assets/img/marker-transparent.png");
            city.infowindow = new google.maps.InfoWindow({
            	content:city.name
            });
            google.maps.event.addListener(city.marker, 'mouseover', function(){
                city.infowindow.open(map,city.marker);
            });
            google.maps.event.addListener(city.marker, 'mouseout', function(){
                city.infowindow.close();
            });
            
        }());
    }
})(jQuery);

