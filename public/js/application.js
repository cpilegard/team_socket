$(document).ready(function() {
	$('#submit').on('click', function() {
		var message = $('#message').val();
		$.ajax({
			url: '/',
			type: 'post',
			data: { message: message }
		}).done(function(response){
			console.log(response);
		}
	});
});
