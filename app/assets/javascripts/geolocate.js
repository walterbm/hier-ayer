function getCoords(callback){
  var latitude, longitude;
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position){
      callback(position.coords.latitude, position.coords.longitude);
    });
  } 
  else {
    alert('Your browser does not support GeoLocation');
  }
}