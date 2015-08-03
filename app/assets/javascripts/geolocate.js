function getCoords(){
if (navigator.geolocation) {
  navigator.geolocation.getCurrentPosition(function(position){
    var coords = [];
    var latitude = position.coords.latitude;
    var longitude = position.coords.longitude;
    coords.push(latitude);
    coords.push(longitude);
    alert(coords);
  });
} else {
  document.write('Your browser does not support GeoLocation');
}
}