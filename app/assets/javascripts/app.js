$(window).ready(function(){
	$("#newThreadBtn").click(function(){
		$(".newThreadContent").fadeIn();
		$(".newThreadBox").slideDown();
	});

	$(".newThreadClose").click(function(){
		$(".newThreadContent").fadeOut();
		$(".newThreadBox").slideToggle();
	});


	
	$("#newReplyBtn").click(function(){
		$(".newReplyContent").fadeIn();
		$(".newReplyBox").slideDown();
	});

	$(".newThreadClose").click(function(){
		$(".newReplyContent").fadeOut();
		$(".newReplyBox").slideToggle();
	});


});