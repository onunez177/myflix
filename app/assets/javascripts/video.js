$(document).ready(function(){
	$("#watch_now").click(
		function()
		{
	  $("#watch_now").hide();
    $("#poster").replaceWith("<h1> Video Player Here!</h1>");
    $.ajax({
      type: "POST"
      url: "/videos/" + id 
      data: id  
    })
	  }
	return false;
	);
});