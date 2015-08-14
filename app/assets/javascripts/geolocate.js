function geo_error() {
  console.log('browser does not support GeoLocation');
}
function getCoordinates(callback){
  var geo_options = {
    enableHighAccuracy: true, 
    maximumAge        : 30000, 
    timeout           : 27000
  };
  navigator.geolocation.getCurrentPosition(function(position){
    callback(position.coords.latitude, position.coords.longitude);
  },geo_error,geo_options);
}