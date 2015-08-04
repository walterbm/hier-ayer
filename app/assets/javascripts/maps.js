
function makeMap(latitude, longitude){
  L.mapbox.accessToken = 'pk.eyJ1IjoiYmVjY2FhZGVzMTciLCJhIjoiYzQ5MDJkNDViNTMxNDljZTZhZDJiYWNmNDBjMGFlMTQifQ.gahZGpjkoGvNTbFE1tEaGg';
var map = L.mapbox.map('map', 'mapbox.run-bike-hike')
   .setView([latitude, longitude], 16);
}