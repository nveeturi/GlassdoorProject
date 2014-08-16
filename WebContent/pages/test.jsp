<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../assets/css/realocation.css" media="screen, projection" id="css-main">
    
<title>Insert title here</title>

<script src="http://www.google.com/jsapi?key=AIzaSyA0APLVAS_phz0CE0stfzyy5yq0e25qdi0;sensor=false" type="text/javascript"></script>
<script src="http://maps.googleapis.com/maps/api/js?libraries=places&sensor=false" type="text/javascript"></script>
    
</head>


<body>

<input type="text" id="start" value="5869 northumberland ST"></input>
	<script>
	var autocompleteStart = new google.maps.places.Autocomplete((document.getElementById('start')), { types: ['geocode'] });
	google.maps.event.addListener(autocompleteStart, 'place_changed', function() {
		startPlace = autocompleteStart.getPlace().name;
	});
	</script>	
	
	
	
</div>

</body>
</html>