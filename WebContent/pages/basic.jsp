
<!DOCTYPE html>
<html>
<head>
    <title>Get polygon example</title>
        
    <!-- stylesheets -->
    <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.css" />
    <link rel="stylesheet" href="assets/plugins/jquery-ui-1.10.0.custom.css"/>
    <link rel="stylesheet" href="assets/css/r360.css"/>

    <style>
        html, body {

            width: 100%;
            height: 100%;
        }

        #map {
            width: 500px;
            height: 400px;
        }
    </style>

    <!-- scripts -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script type="text/javascript" src="assets/plugins/bootstrap/js/bootstrap.min.js"></script> 
    <script src="assets/plugins/jquery-ui-1.9.2.custom.min.js"></script>
    <script src="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.js"></script>
    <script src="assets/js/underscore.js"></script>
    <script src="assets/js/raphael-min.js"></script>
    <script src="assets/js/r360.js"></script>

     <script type="text/javascript">
        $(document).ready(function(){

            var latlon = [52.51, 13.37];

            // add the map and set the initial center to berlin
            var map = L.map('map').setView(latlon, 13);
            // attribution to give credit to OSM map data and VBB for public transportation 
                        // initialising the base map. To change the base map just change following
            // lines as described by cloudmade, mapbox etc..
            // note that mapbox is a paided service
            L.tileLayer('http://a.tiles.mapbox.com/v3/mi.h220d1ec/{z}/{x}/{y}.png', {
                    maxZoom: 18
            }).addTo(map);

            // set the service key, this is a demo key
            // please contact us and request your own key
            r360.config.serviceKey = 'C6UAZQHErAfbv2sqqUJP';

            // create a marker and add it to the map
            var marker = L.marker(latlon);
            marker.lat = latlon[0];
            marker.lon = latlon[1];
            marker.addTo(map);

            // create the layer to add the polygons
            var cpl = r360.route360PolygonLayer();
            // add it to the map
            map.addLayer(cpl);

            // you need to define some options for the polygon service
            // for more travel options check out the other tutorials
            var travelOptions = r360.travelOptions();
            // we only have one source which is the marker we just added
            travelOptions.addSource(marker);
            // we want to have polygons for 5 to 30 minutes
            travelOptions.setTravelTimes([300, 600,900, 1200, 1500, 1800]);

            // call the service
            r360.PolygonService.getTravelTimePolygons(travelOptions, function(polygons){
                    
                // add the returned polygons to the polygon layer 
                cpl.addLayer(polygons);
                
                // zoom the map to fit the polygons perfectly
                map.fitBounds(cpl.getBoundingBox());
            });
        });
    </script>

</head>
<body>
    <div id="map"></div>
</body>
</html>