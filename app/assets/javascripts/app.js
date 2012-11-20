$(window).ready(function(){
	$("#newThreadBtn").click(function(){
		$(".newThreadContent").fadeIn();
		$(".newThreadBox").slideDown();
	});

	$(".newThreadClose").click(function(){
		$(".newThreadContent").fadeOut();
		$(".newThreadBox").slideToggle();
	});
});