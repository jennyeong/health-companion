let setDatepicker = () => {
	$('#datepicker').datepicker();
}

$(document).on('turbolinks:load', () => {
	setDatepicker();
})