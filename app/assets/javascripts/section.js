jQuery( document ).ready(function( $ ) {
	$(".duplicate-canvas-course").click(function(){
		console.log("checking status...");
		var id = $(this).data('section-id');
		json = checkStatus(id);
		if ( json.status < 1 ){
			console.log("starting process...");
			toastr.success("Status: Starting duplication...");
			startProcess(id);
		} else {
			console.log("it looks like the duplication is done... why are you trying again?  ");
			toastr.warning("Status: Duplication already begun.... ")
			window.location.reload(true); 
		}
	});

	function startProcess(id){
		$.ajax({
			type: "POST",
			dataType: "json",
			data: { "id": id },
			url: '/sections/' + id + '/duplicate_parent_activities',
			success: function(json){
				json = checkStatus(id);
				// Change the button.... disable it

				toastr.success(json);
			},
			error: function(jqXHR, textStatus, errorThrown){
				switch (jqXHR.status) {
					case 201:
					case 200: 
						toastr.success('Duplication complete');
						break;
					case 401: 
						toastr.error('You must be logged in to update interview information.  <br /> Click <a href="/staff/login?ref=offlineform" alt="Log in">here to login</a>', "error");
						break;
					case 500:
						toastr.error('An error prevented your interview information from being updated.  Error: ' + jqXHR.status , "error");
						break;
					default:
						toastr.error('An error prevented your interview information from being updated.  Error: ' + jqXHR.status , "error");
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
			success: function(status){
				console.log("check status complete with success...");
				if ( status > ".95" ) {
					return { 
							"finished": "true",
							"status": 100
						};
				} else {
					return { 
							"finished": "false",
							"status": status * 100
						};
				}
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

				return { 
						"finished": "unknown",
						"status": jqXHR.status
					};
			}
		});

		console.log("just finished checking status request...");

	}
});