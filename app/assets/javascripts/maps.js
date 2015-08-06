function makeMap(url,mapId){
  L.mapbox.accessToken = 'pk.eyJ1Ijoid2FsdGVyYm0iLCJhIjoiMDU5ODljMDBjNzg3ZThlZTJlMTAwYWRhMTFjYWE0MzUifQ.CJ0ZCaTRHRMJTWDE0kIubA';
  var map = L.mapbox.map('map-'+mapId, 'mapbox.run-bike-hike',{
    scrollWheelZoom: false,
    compact: true,
    animate: true
  }).setView([0,0],1);
  var myLayer = L.mapbox.featureLayer().addTo(map);

  $.get(url, function( data ) {
    if (data.length === 0) {
      getCoordinates(function(latitude,longitude){
        map.setView([latitude,longitude],13);
      });
    }
    else{
      latitude = data[0].geometry.coordinates[1];
      longitude = data[0].geometry.coordinates[0];
      map.setView([latitude,longitude],13);
      myLayer.setGeoJSON({
        type: 'FeatureCollection',
        features: data
      });
      // leaflet bug hacked to fit markers in map
      setTimeout(function () {
        map.fitBounds(myLayer.getBounds());
      }, 0);
      
      myLayer.eachLayer(function(layer) {
        if(layer.feature.properties.image == "/images/original/missing.png"){
          var content = '<h2>'+ layer.feature.properties.description +'<\/h2>';
        }else{
          var content = '<img src="'+ layer.feature.properties.image+'" alt="" style="width:100%;height:100%">' + '<p>'+ layer.feature.properties.description +'<\/p>';
        }
        layer.bindPopup(content);
      });
      
      // ANIMATED LINE
      var polyline_options = {color: '#000'};
      var polyline = L.polyline([], polyline_options).addTo(map);
      var line = [];
      myLayer.eachLayer(function(marker) {line.push(marker.getLatLng())});
      var i = 0;
      function add() {
          polyline.addLatLng(L.latLng(line[i]));
          map.setView(line[i]);
          if (++i < line.length) window.setTimeout(add, 1000);
          // change the second argument in setTimeout to adjust speed of animation
      }
      add();
      
      // WORKING STATIC LINE
      // var line = [];
      // myLayer.eachLayer(function(marker) {line.push(marker.getLatLng())});
      // var polyline_options = {color: '#000'};
      // var polyline = L.polyline(line, polyline_options).addTo(map);
    } 
  });  
}