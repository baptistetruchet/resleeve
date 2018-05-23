function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var bodyAddress = document.getElementById('body_location');

    if (bodyAddress) {
      var autocomplete = new google.maps.places.Autocomplete(bodyAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(bodyAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocomplete };
