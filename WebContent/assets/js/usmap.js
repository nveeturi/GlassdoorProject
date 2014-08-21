(function ($) {
	jQuery("#usmap").height(jQuery(window).height());
    
    var map = new google.maps.Map(document.getElementById("usmap"), {
        mapTypeId: google.maps.MapTypeId.ROADMAP, 
        zoom: 5, 
        center: new google.maps.LatLng(39.62788622550727,-100.11621093749999),
        styles : [{"featureType":"water","elementType":"geometry","stylers":[{"color":"#a2daf2"}]},{"featureType":"landscape.man_made","elementType":"geometry","stylers":[{"color":"#f7f1df"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#d0e3b4"}]},{"featureType":"landscape.natural.terrain","elementType":"geometry","stylers":[{"visibility":"off"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#bde6ab"}]},{"featureType":"poi","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"poi.medical","elementType":"geometry","stylers":[{"color":"#fbd3da"}]},{"featureType":"poi.business","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#ffe15f"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#efd151"}]},{"featureType":"road.arterial","elementType":"geometry.fill","stylers":[{"color":"#ffffff"}]},{"featureType":"road.local","elementType":"geometry.fill","stylers":[{"color":"black"}]},{"featureType":"transit.station.airport","elementType":"geometry.fill","stylers":[{"color":"#cfb2db"}]}],
    });
    
    navigator.geolocation.getCurrentPosition(function(position) {
    	var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
    	var infowindow = new google.maps.InfoWindow({
            map: map,
            position: pos,
            content: 'You are here!'
          });
	});
    
    var cities = [{name: "Houston", 
        cityid: "houston", 
        lat: 29.757,
        lng: -95.372
        },{name: "Madison", 
        cityid: "madison", 
        lat: 43.0730517,
        lng: -89.4012302
        },{name: "Sonoma County", 
        cityid: "sonoma", 
        lat: 38.51,
        lng: -122.93
        },{name: "Milwaukee", 
        cityid: "milwaukee", 
        lat: 43.0389025,
        lng: -87.9064736
        },{name: "Ann Arbor", 
        cityid: "annarbor", 
        lat: 42.2708716,
        lng: -83.7263294
        },{name: "Denver", 
        cityid: "denver", 
        lat: 39.7391536,
        lng: -104.9847034
        },{name: "Eugene", 
        cityid: "eugene", 
        lat: 44.0461415751,
        lng: -123.085327148
        },{name: "Miami", 
        cityid: "miami", 
        lat: 25.7863,
        lng: -80.2235
        },{name: "Orlando", 
        cityid: "orlando", 
        lat: 28.538335,
        lng: -81.379236
        },{name: "Detroit", 
        cityid: "detroit", 
        lat: 42.3453503429,
        lng: -83.0600738525
        },{name: "Colorado Springs", 
        cityid: "coloradosprings", 
        lat: 38.8338816,
        lng: -104.8213634
        },{name: "Cleveland", 
        cityid: "cleveland", 
        lat: 41.4994954,
        lng: -81.6954088
        },{name: "Chicago", 
        cityid: "chicago", 
        lat: 41.8747,
        lng: -87.6249
        },{name: "Delaware", 
        cityid: "delaware", 
        lat: 39.2174922589,
        lng: -75.3631210328
        },{name: "St. Louis", 
        cityid: "stlouis", 
        lat: 38.646991,
        lng: -90.224967
        },{name: "Columbus", 
        cityid: "columbus", 
        lat: 39.9611755,
        lng: -82.9987942
        },{name: "Los Angeles", 
        cityid: "losangeles", 
        lat: 34.0387110284,
        lng: -118.247591217
        },{name: "Sarasota", 
        cityid: "sarasota", 
        lat: 27.3364347,
        lng: -82.5306527
        },{name: "Nashville", 
        cityid: "nashville", 
        lat: 36.1711397671,
        lng: -86.7782592773
        },{name: "Fayetteville", 
        cityid: "fayetteville-ar", 
        lat: 36.0625795,
        lng: -94.1574263
        },{name: "Salem, OR", 
        cityid: "salem-or", 
        lat: 44.9428975,
        lng: -123.0350963
        },{name: "San Luis Obispo", 
        cityid: "sanluisobispo", 
        lat: 35.2827524,
        lng: -120.6596156
        },{name: "Bay Area", 
        cityid: "bayarea", 
        lat: 37.3494177799,
        lng: -121.993560791
        },{name: "Raleigh/Durham", 
        cityid: "raleigh", 
        lat: 35.8718032616,
        lng: -78.7074279785
        },{name: "Austin", 
        cityid: "austin", 
        lat: 30.2644,
        lng: -97.7385
        },{name: "Washington D.C.", 
        cityid: "washington", 
        lat: 38.8977,
        lng: -77.0351
        },{name: "Kansas City", 
        cityid: "kansascity", 
        lat: 39.0949,
        lng: -94.5724
        },{name: "Philadelphia", 
        cityid: "philadelphia", 
        lat: 39.9471,
        lng: -75.1588
        },{name: "Las Vegas", 
        cityid: "lasvegas", 
        lat: 36.114646,
        lng: -115.172816
        },{name: "New York", 
        cityid: "newyork", 
        lat: 40.729,
        lng: -73.998
        },{name: "Pittsburgh", 
        cityid: "pittsburgh", 
        lat: 40.4406248,
        lng: -79.9958864
        },{name: "Asheville, NC", 
        cityid: "asheville", 
        lat: 35.6009452,
        lng: -82.554015
        },{name: "Salt Lake City", 
        cityid: "saltlakecity", 
        lat: 40.7607793,
        lng: -111.8910474
        },{name: "Spokane", 
        cityid: "spokane", 
        lat: 47.6587802,
        lng: -117.4260466
        },{name: "Atlanta", 
        cityid: "atlanta", 
        lat: 33.748,
        lng: -84.387
        },{name: "Tampa", 
        cityid: "tampa", 
        lat: 27.949436,
        lng: -82.4651441
        },{name: "Toronto/Hamilton", 
        cityid: "toronto", 
        lat: 43.716527305,
        lng: -79.32472229
        },{name: "San Diego", 
        cityid: "sandiego", 
        lat: 32.711,
        lng: -117.1534
        },{name: "Blacksburg", 
        cityid: "blacksburg", 
        lat: 37.2199401087,
        lng: -80.4061889648
        },{name: "Boston", 
        cityid: "boston", 
        lat: 42.3584308,
        lng: -71.0597732
        },{name: "Minneapolis", 
        cityid: "minneapolis", 
        lat: 44.9799654,
        lng: -93.2638361
        },{name: "Seattle", 
        cityid: "seattle", 
        lat: 47.6038889353,
        lng: -122.297417566
        },{name: "Portland", 
        cityid: "portland", 
        lat: 45.5203,
        lng: -122.6713
        },{name: "Albany", 
        cityid: "albany", 
        lat: 42.6525793,
        lng: -73.7562317
        },{name: "Rochester", 
        cityid: "rochester", 
        lat: 43.16103,
        lng: -77.6109219
        },{name: "Dallas", 
        cityid: "dallas", 
        lat: 32.7994,
        lng: -96.7655
        },{name: "Phoenix", 
        cityid: "phoenix", 
        lat: 33.45,
        lng: -112.07
        },{name: "Sacramento", 
        cityid: "sacramento", 
        lat: 38.5776947744,
        lng: -121.3687132
        },{name: "Hampton Roads", 
        cityid: "hamptonroads", 
        lat: 36.8592957813,
        lng: -76.2835693359
        },{name: "Little Rock, AR", 
        cityid: "littlerock", 
        lat: 34.746,
        lng: -92.288
        },{name: "Baltimore", 
        cityid: "baltimore", 
        lat: 39.2903848,
        lng: -76.6121893
        },{name: "Buffalo", 
        cityid: "buffalo", 
        lat: 42.8970946032,
        lng: -78.879776001
        }];
    var closeAll = function(){
        for (var i=0;i<cities.length; i++){
            cities[i].infowindow.close();
        }
    };
    for (var i=0;i<cities.length; i++) {
        (function(){
            var city, markerOptions;
            city = cities[i];
            markerOptions = {};
            markerOptions.position = new google.maps.LatLng(city.lat, city.lng);
            markerOptions.map = map;
            
            city.marker = new google.maps.Marker(markerOptions);
            city.marker.setIcon("../assets/img/icons/marker_red.png");
            city.infowindow = new google.maps.InfoWindow({
            	content:city.name
            });
            google.maps.event.addListener(city.marker, 'click', function(){
                document.location.href = '../pages/pittsburgh.jsp'; 
            });
            google.maps.event.addListener(city.marker, 'mouseover', function(){
                city.infowindow.open(map,city.marker);
            });
            google.maps.event.addListener(city.marker, 'mouseout', function(){
                city.infowindow.close();
            });
            
        }());
    }
    jQuery(".toggle").live("click", function(e){
        e.preventDefault();
        var obj = jQuery(jQuery(this).attr("href"));
        if(obj.css("display") == "none"){
            obj.fadeIn(400);
        } else {
            obj.fadeOut(400);
        }
    });
    jQuery("a[rel='external']").click(function(e){
        e.preventDefault();
        window.open($(this).attr("href"));
    });
    $(window).resize(function(){
        jQuery("#index-map").height(jQuery(window).height());
        google.maps.event.trigger("resize", map);
    });
})(jQuery);