jQuery( document ).ready(function( $ ) {
	$(".duplicate-canvas-course").click(function(){
		console.log("checking status...");
		var id = $(this).data('section-id');
		checkStatus(id);
		console.log("starting process...");
		startProcess(id);
	})
	$(".check-status").click(function(){
		console.log("HI check !!");
		var id = $(this).data('section-id');
		checkStatus(id);
	})
	function startProcess(id){
		$.ajax({
			type: "GET",
			dataType: "json",
			url: '/sections/' + id + '/duplicate_parent_activities',
			success: function(json){
				toastr.success('Good going!!');
			},
			error: function(jqXHR, textStatus, errorThrown){
				switch (jqXHR.status) {
					case 401: 
						toastr.error('You must be logged in to update interview information.  <br /> Click <a href="/staff/login?ref=offlineform" alt="Log in">here to login</a>', "error");
						break;
					case 500:
						toastr.error('An error prevented your interview information from being updated.', "error");
						break;
					default:
						toastr.error('An error prevented your interview information from being updated.', "error");
						break;
				}
			}
		});
	}
	function checkStatus(id){
		console.log("just about to fire check status request...");

		$.ajax({
			type: "GET",
			dataType: "json",
			url: '/sections/' + id + '/duplication_status.json',
			success: function(json){
				toastr.success('Status: ' + json);
			},
			error: function(jqXHR, textStatus, errorThrown){
				switch (jqXHR.status) {
					case 401:
						toastr.error('You must be logged in to update interview information.  <br /> Click <a href="/staff/login?ref=offlineform" alt="Log in">here to login</a>', "error");
					case 500:
						toastr.error('An error prevented your interview information from being updated.', "error");
					default:
						toastr.error('An error prevented your interview information from being updated.', "error");
				}
			}
		});

		console.log("just finished checking status request...");

	}
});