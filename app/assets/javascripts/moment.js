function makeMap(longitude, latitude){
  L.mapbox.accessToken = 'pk.eyJ1IjoiYmVjY2FhZGVzMTciLCJhIjoiYzQ5MDJkNDViNTMxNDljZTZhZDJiYWNmNDBjMGFlMTQifQ.gahZGpjkoGvNTbFE1tEaGg';
  var map = L.mapbox.map('map', 'beccaades17.96d679b4').setView([longitude, latitude], 10);
  var myLayer = L.mapbox.featureLayer.addTo(map);
  myLayer.on('layeradd', function(e) {
    var marker, popupContent, properties;
    marker = e.layer;
    properties = marker.feature.properties;
    popupContent = '<div class="popup"><h3><a href="/markers/' + properties.id + '" target="marker">' + properties.name + '</a></h3><p class="popup-num">Marker No. ' + properties.number + '</p><p>' + properties.description + '</p></div>';
    return marker.bindPopup(popupContent, {
      closeButton: false,
      minWidth: 300  
    });
  $.ajax({
    dataType: 'text',
    url: '/create_json',
    success: function(data) {
      var geojson;
      geojson = $.parseJSON(data);
      return myLayer.setGeoJSON(geojson);
    }
  });