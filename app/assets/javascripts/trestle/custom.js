// This file may be used for providing additional customizations to the Trestle
// admin. It will be automatically included within all admin pages.
//
// For organizational purposes, you may wish to define your customizations
// within individual partials and `require` them here.
//
//  e.g. //= require "trestle/custom/my_custom_js"
//= require "trestle/imgupload.js"


$(document).on('turbolinks:load', function() {
	$("#arraylist").on('click', '.clickadd', function(event) {
		event.preventDefault();

		var group = $(this).parents(".row").html();
		$(this).removeClass('clickadd');
		
		$("#arraylist").find(".row:last").after('<div class="row">' + group + '</div>');
	});

});
