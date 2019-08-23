$(document).on('turbolinks:load', function() {
	$(".thumbimg").change(function(event) {
		var input = $(event.currentTarget);
		var file = input[0].files[0];
		var reader = new FileReader();
		reader.onload = function(e){
			image_base64 = e.target.result;
			$("#thumbpreview").html('<img src="' + image_base64 + '" class="thumbimg img-responsive" />')
		}

		reader.readAsDataURL(file);
	});

	$("#mutiupload").change(function(event) {
		var input = event.currentTarget;
		var fileCount = input.files.length;

		for (var i = 0; i < fileCount; i++) {
			var file = input.files[i];

			//Only pics
			// if (!file.type.match('image')) continue;
			
			var reader = new FileReader();
			reader.onload = function (e) {
				var picFile = e.target;
				var prevHtml = "<div class='gallery-img insertImg'>" + 
				"<img class='previewImg' src='" + picFile.result + "' />" +  
				"</div>";

				jQuery('#galleryList').append(prevHtml);
			}

			reader.readAsDataURL(file);
		}
	});
})