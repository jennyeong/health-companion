// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";
import "bootstrap";

function init() {
  $(".show-next-time-btn").on("click", function() {
    $(this).siblings(".time-container:hidden").first().show();
    if ($(this).siblings(".time-container:hidden").length < 1) {
      $(this).hide(); 
    }
  })
}
$(document).on('ready turbo:load', init());
