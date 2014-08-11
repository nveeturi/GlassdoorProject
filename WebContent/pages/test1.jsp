<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html dir="ltr" lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <title>Mapnificent Los Angeles - Dynamic Public Transport Travel Time Maps for Los Angeles</title>
        <link rel="icon" type="image/png" href="/media/img/favicon.png" />
        <!--[if IE]>
        <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
       
        <link href="/media/css/screen.min.css" rel="stylesheet" type="text/css" media="screen,projection" />        
        
        <link type="text/css" href="/media/css/smoothness/jquery-ui.css" rel="stylesheet" />
        <meta name="robots" content="index, follow" />
        <meta name="keywords" content="Mapnificent Isochrone Maps Travel Time Public Transport Los Angeles" /> 
        <meta name="description" content="Mapnificent shows you areas you can reach with public transport in Los Angeles." /> 
        <!-- <script type="text/javascript" src="http://www.google.com/jsapi?key=ABQIAAAAIIC6NMcawLeTWKvhEPhJEBTCfEqn7ZHAgoqnlvF7Z4lQiS11bBRdBz_D_UyO9BGIJ26Z2y2wK2EDrQ&amp;hl=de"></script> -->
        
        <script src="http://www.google.com/jsapi?key=AIzaSyA0APLVAS_phz0CE0stfzyy5yq0e25qdi0" type="text/javascript"></script>
        <script type="text/javascript" charset="utf-8">
            google.load("maps", "3", {other_params:"sensor=false"});
            google.load("search", "1", {nocss:1});
        </script>
        
        <script src="/media/js/jquery-all.js" type="text/javascript" charset="utf-8"></script>
       
        <script type="text/javascript">
            try {
                var _gaq = _gaq || [];
                _gaq.push(['_setAccount', 'UA-15128105-1'],
                  ['_setCustomVar', 1, 'City', 'losangeles', 3],
                  ['_trackPageview']);
            } catch(err) {}
            (function() {
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
            })();
        </script>
    </head>
    <body>
        <header id="topnav">
            <h1 id="about-header"><a href=".">Los Angeles</a></h1>
            <span style="position:absolute;top:4px;left:122px;font-size:6pt;color:#aaa;">Beta</span>
            <nav class="nav">
                <ul id="topnav-list">
                    <li><a class="listicon" href="/" id="mapnificent-world">More Cities</a></li>
                    <li><a class="listicon toggle" href="#about" id="mapnificent-about">About Mapnificent</a></li>
                    <li><a class="listicon toggle" id="mapnificent-settings" href="#configure">Settings</a></li>
                    <li class="bigger-listitem">
                                                <div class="nav-label">Drop me<br/>on the map:</div>
                        <div id="urbanDistance-markerrepo" class="markerrepo"><img id="urbanDistance-markerrepo-marker" class="markerrepo-marker" src="http://gmaps-samples.googlecode.com/svn/trunk/markers/orange/blank.png" alt="New Starting Point"/></div>

                    </li>
                    <li class="bigger-listitem" id="searcharea"><div class="nav-label"><label for="urbanDistance-search">Search area<br/>with Google:</label></div><div class="right"><input type="search" id="urbanDistance-search" size="16" placeholder="e.g. Coffee"><button id="clear-search" style="visibility:hidden">X</button><img id="urbanDistance-search-indicator" style="visibility:hidden;margin:4px 0 0" src="/media/img/refresh.gif" alt="Refreshing"></div></li>
                </ul>
            </nav>

        </header>
        <div id="map"></div>
        <section id="about" class="vcard contentoverlay">
            <a class="close toggle" href="#about">close</a>
            <h2 class="center">It's <img style="vertical-align:middle;margin:10px 0 0;" src="/media/img/mapnificent_medium.png" alt="Mapnificent"/></h2>
<p>Mapnificent shows you the area you can reach with public transport from any point in a given time. It is available for major cities in the US and world wide.</p>
<p>You may be interested to watch a <a href="http://vimeo.com/16362921">video about what Mapnificent can do</a>, read a <a href="http://blog.stefanwehrmeyer.com/post/1448498820/a-mapnificent-world">blog post about how Mapnificent works</a> or jump to the <a href="/docs/">Mapnificent API Documentation</a>.
<p>Mapnificent was originally inspired by MySociety's <a href="http://mapumental.channel4.com">Mapumental</a> which is sadly still in private beta.</p>
<address id="contact"> 
    <p>Mapnificent was created by <a class="url" href="http://stefanwehrmeyer.com" title="Stefan Wehrmeyer"><span class="given-name">Stefan</span><span class="family-name">Wehrmeyer</span></a>.</p>
    <p>
        <a href="#feedback" onclick="UserVoice.Popin.show(); return false;">Please give feedback</a> or contact me directly at <a class="email" href="mailto:mail@mapnificent.net">mail@mapnificent.net</a>.</p>
    <p class="adr"> 
        <span class="street-address">Jägerweg 10</span><br/> 
        <span class="postal-code">53177</span> <span class="locality">Bonn</span>,
        <span class="country-name">Germany</span>
    </p> 
</address> 
<p>Follow <a href="http://twitter.com/mapnificent">@mapnificent on Twitter here!</a></p>
        </section>
        <section id="terms-of-use" class="contentoverlay">
            <a class="close toggle" href="#terms-of-use">close</a>
            <iframe style="width:400px;height:350px;overflow:scroll;" src="/docs/tos.html"></iframe>
        </section>
        <div id="controls" class="controlsoverlay"></div>
        <div id="message" class="shortoverlay" style="display:none"></div>
        
        <div id="copyright-notice">
            <a class="close toggle" href="#copyright-notice"></a>
            <div id="search-attribution" style="display:none"></div><div id="osm-copyright" style="display:none">(c) Map Tiles <a href="http://www.openstreetmap.org/">OpenStreetMap</a></div>No Warranties: <a class="toggle" href="#terms-of-use">Terms of Use</a><br/>For trip planning services see links below. Data Copyright Holders are:<p>(c) <a href="http://www.metro.net/">Los Angeles County Metropolitan Transportation Authority</a> (<a href="http://developer.metro.net/policies/terms/">Terms of Use</a>)</p>
<p>(c) <a href="http://www.metrolinktrains.com/help/page/title/developer_resources">MetroLink</a></p>
<p><a href="http://www.bigbluebus.com/contactus/index.asp">Contact Big Blue Bus and ask them to release GTFS data!</a></p>
<p><a href="http://www.culvercity.org/en/Government/Transportation/Bus/ContactUs.aspx">Contact Culver City Administration and ask them to release GTFS data</a></p></div>
        
        <script src="/media/js/main.js" type="text/javascript" charset="utf-8"></script>
        
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
                var options = {"mapStartCenter": {"lat": 34.0387110284, "lng": -118.247591217},
                        "mapStartZoom": 12,
                        "dataUrlPrefix": "http://mapnificent.stefanwehrmeyer.com/data/",
                        "layerSettings": {"urbanDistance": {"estimatedMaxCalculateCalls": 500000,
"maxWalkTravelTime": 240}}
                    };
                var version = '6';
                if (search.indexOf('version') !== -1) {
                    version = search.substring(1).split('=')[1];
                }
                options.layerSettings.urbanDistance.cityData = 'losangeles-' + version;
                options.layerSettings.urbanDistance.northwest = {"lat":34.697579, "lng":-119.206025};
                options.layerSettings.urbanDistance.southeast = {"lat":33.191554, "lng":-117.309089};
                options.layerSettings.urbanDistance.copyright = "\x3Cp\x3E(c) \x3Ca href\x3D\x22http://www.metro.net/\x22\x3ELos Angeles County Metropolitan Transportation Authority\x3C/a\x3E (\x3Ca href\x3D\x22http://developer.metro.net/policies/terms/\x22\x3ETerms of Use\x3C/a\x3E)\x3C/p\x3E\x0D\x0A\x3Cp\x3E(c) \x3Ca href\x3D\x22http://www.metrolinktrains.com/help/page/title/developer_resources\x22\x3EMetroLink\x3C/a\x3E\x3C/p\x3E\x0D\x0A\x3Cp\x3E\x3Ca href\x3D\x22http://www.bigbluebus.com/contactus/index.asp\x22\x3EContact Big Blue Bus and ask them to release GTFS data!\x3C/a\x3E\x3C/p\x3E\x0D\x0A\x3Cp\x3E\x3Ca href\x3D\x22http://www.culvercity.org/en/Government/Transportation/Bus/ContactUs.aspx\x22\x3EContact Culver City Administration and ask them to release GTFS data\x3C/a\x3E\x3C/p\x3E";
                mapnificent = Mapnificent(options);
            }());
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
                },{name: "Canberra", 
                cityid: "canberra", 
                lat: -35.2819998,
                lng: 149.1286843
                },{name: "Brisbane", 
                cityid: "brisbane", 
                lat: -27.48,
                lng: 153.03
                },{name: "Edmonton", 
                cityid: "edmonton", 
                lat: 53.543564,
                lng: -113.490452
                },{name: "Flemish Region", 
                cityid: "flemish-region", 
                lat: 50.845838769,
                lng: 4.37255859375
                },{name: "London", 
                cityid: "london", 
                lat: 51.500515,
                lng: -0.128317
                },{name: "Milwaukee", 
                cityid: "milwaukee", 
                lat: 43.0389025,
                lng: -87.9064736
                },{name: "Ann Arbor", 
                cityid: "annarbor", 
                lat: 42.2708716,
                lng: -83.7263294
                },{name: "Auckland", 
                cityid: "auckland", 
                lat: -36.84765,
                lng: 174.766
                },{name: "Paris", 
                cityid: "paris", 
                lat: 48.856614,
                lng: 2.3522219
                },{name: "Denver", 
                cityid: "denver", 
                lat: 39.7391536,
                lng: -104.9847034
                },{name: "Winnipeg", 
                cityid: "winnipeg", 
                lat: 49.886083,
                lng: -97.152921
                },{name: "Perth", 
                cityid: "perth", 
                lat: -31.95588,
                lng: 115.85898
                },{name: "Vancouver", 
                cityid: "vancouver", 
                lat: 49.248523,
                lng: -123.1088
                },{name: "Darwin", 
                cityid: "darwin", 
                lat: -12.4618879392,
                lng: 130.841503143
                },{name: "Eugene", 
                cityid: "eugene", 
                lat: 44.0461415751,
                lng: -123.085327148
                },{name: "Coimbra", 
                cityid: "coimbra", 
                lat: 40.210245,
                lng: -8.4269
                },{name: "Budapest", 
                cityid: "budapest", 
                lat: 47.4984056,
                lng: 19.0407578
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
                },{name: "São Paulo", 
                cityid: "saopaulo", 
                lat: -23.5489433,
                lng: -46.6388182
                },{name: "Rennes", 
                cityid: "rennes", 
                lat: 48.1117611,
                lng: -1.6802654
                },{name: "Colorado Springs", 
                cityid: "coloradosprings", 
                lat: 38.8338816,
                lng: -104.8213634
                },{name: "Madrid", 
                cityid: "madrid", 
                lat: 40.4166909,
                lng: -3.7003454
                },{name: "Cleveland", 
                cityid: "cleveland", 
                lat: 41.4994954,
                lng: -81.6954088
                },{name: "Halifax", 
                cityid: "halifax", 
                lat: 44.6516808708,
                lng: -63.6029434204
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
                },{name: "Stavanger", 
                cityid: "stavanger", 
                lat: 58.9699756,
                lng: 5.7331073
                },{name: "Dublin", 
                cityid: "dublin", 
                lat: 53.35,
                lng: -6.26
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
                },{name: "Montréal", 
                cityid: "montreal", 
                lat: 45.506828121,
                lng: -73.564453125
                },{name: "Toulouse", 
                cityid: "toulouse", 
                lat: 43.604,
                lng: 1.444
                },{name: "Washington D.C.", 
                cityid: "washington", 
                lat: 38.8977,
                lng: -77.0351
                },{name: "Vitoria-Gasteiz", 
                cityid: "vitoria-gasteiz", 
                lat: 42.8467181,
                lng: -2.6716351
                },{name: "Kansas City", 
                cityid: "kansascity", 
                lat: 39.0949,
                lng: -94.5724
                },{name: "Strasbourg", 
                cityid: "strasbourg", 
                lat: 48.583148,
                lng: 7.747882
                },{name: "Philadelphia", 
                cityid: "philadelphia", 
                lat: 39.9471,
                lng: -75.1588
                },{name: "Calgary", 
                cityid: "calgary", 
                lat: 51.045,
                lng: -114.0572222
                },{name: "Valencia", 
                cityid: "valencia", 
                lat: 39.4702393,
                lng: -0.3768049
                },{name: "Las Vegas", 
                cityid: "lasvegas", 
                lat: 36.114646,
                lng: -115.172816
                },{name: "New York", 
                cityid: "newyork", 
                lat: 40.729,
                lng: -73.998
                },{name: "Greater Manchester", 
                cityid: "manchester", 
                lat: 53.4807125,
                lng: -2.2343765
                },{name: "Pavia", 
                cityid: "pavia", 
                lat: 45.184725,
                lng: 9.158207
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
                },{name: "Ulm", 
                cityid: "ulm", 
                lat: 48.3989131644,
                lng: 9.98415551856
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
                },{name: "Adelaide", 
                cityid: "adelaide", 
                lat: -34.9305556,
                lng: 138.6205556
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
                },{name: "Oslo", 
                cityid: "oslo", 
                lat: 59.95,
                lng: 10.75
                },{name: "Torino", 
                cityid: "torino", 
                lat: 45.0705621,
                lng: 7.6866186
                },{name: "Berlin", 
                cityid: "berlin", 
                lat: 52.525592,
                lng: 13.369545
                },{name: "Tel Aviv", 
                cityid: "telaviv", 
                lat: 32.066,
                lng: 34.778
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
                },{name: "Bordeaux", 
                cityid: "bordeaux", 
                lat: 44.837789,
                lng: -0.57918
                },{name: "Nantes", 
                cityid: "nantes", 
                lat: 47.218371,
                lng: -1.553621
                },{name: "Helsinki", 
                cityid: "helsinki", 
                lat: 60.1698125,
                lng: 24.9382401
                },{name: "Wellington", 
                cityid: "wellington", 
                lat: -41.2932854608,
                lng: 174.78012085
                },{name: "Ottawa", 
                cityid: "ottawa", 
                lat: 45.4182144006,
                lng: -75.6930541992
                },{name: "Baltimore", 
                cityid: "baltimore", 
                lat: 39.2903848,
                lng: -76.6121893
                },{name: "Buffalo", 
                cityid: "buffalo", 
                lat: 42.8970946032,
                lng: -78.879776001
                }];
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
                for (var i=0;i<cities.length; i++){
                    (function(){
                        var city, markerOptions;
                        city = cities[i];
                        markerOptions = {}
                        markerOptions.position = new google.maps.LatLng(city.lat, city.lng);
                        markerOptions.map = mapnificent.map;
                        markerOptions.title = city.name;
                        city.marker = new google.maps.Marker(markerOptions);
                        city.infowindow = new google.maps.InfoWindow();
                        google.maps.event.addListener(city.marker, 'click', function(){
                            mapnificent.map.panTo(markerOptions.position);
                            city.infowindow.setContent('<a href="/'+city.cityid+'/">'+
                                '<div class="mapnificent-city">'+ city.name +'</div>'+
                            '</a>');
                            city.infowindow.open(mapnificent.map, city.marker);
                        });
                    }());
                }
            };
            google.setOnLoadCallback(google_init);
        if (document.location.search.indexOf('hidecontrols') === -1) {
          var uservoiceOptions = {
            key: 'mapnificent',
            host: 'mapnificent.uservoice.com', 
            forum: '82843',
            alignment: 'left',
            background_color:'#76bb00', 
            text_color: 'white',
            hover_color: '#49c700',
            lang: 'en',
            showTab: true
          };
          function _loadUserVoice() {
            var s = document.createElement('script');
            s.src = ("https:" == document.location.protocol ? "https://" : "http://") + "uservoice.com/javascripts/widgets/tab.js";
            document.getElementsByTagName('head')[0].appendChild(s);
          }
          _loadSuper = window.onload;
          window.onload = (typeof window.onload != 'function') ? _loadUserVoice : function() { _loadSuper(); _loadUserVoice(); };
        }
        </script>
    </body>
</html>
