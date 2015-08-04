
function makeMap(longitude, latitude){
  L.mapbox.accessToken = 'pk.eyJ1IjoiYmVjY2FhZGVzMTciLCJhIjoiYzQ5MDJkNDViNTMxNDljZTZhZDJiYWNmNDBjMGFlMTQifQ.gahZGpjkoGvNTbFE1tEaGg';
  var map = L.mapbox.map('map', 'beccaades17.96d679b4').setView([longitude, latitude], 10);
}