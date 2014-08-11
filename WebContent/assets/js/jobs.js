
$(document).ready(function(){
	var navH = 50;
	$(window).scroll(function() {
		var scroH = $(this).scrollTop();
		if (scroH > navH && scroH < 500) {
			$(".mapdiv").css({
				"position": "fixed",
				"top": "120px"
			});
		} else {
			$(".mapdiv").css({
				"position": "relative"
			});
		} 
	});
});