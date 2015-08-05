function makeCurrentMap(latitude, longitude){
  L.mapbox.accessToken = 'pk.eyJ1Ijoid2FsdGVyYm0iLCJhIjoiMDU5ODljMDBjNzg3ZThlZTJlMTAwYWRhMTFjYWE0MzUifQ.CJ0ZCaTRHRMJTWDE0kIubA';
  var map = L.mapbox.map('map', 'mapbox.run-bike-hike')
   .setView([latitude, longitude], 16);
  L.mapbox.featureLayer({
    // this feature is in the GeoJSON format: see geojson.org
    // for the full specification
    type: 'Feature',
    geometry: {
        type: 'Point',
        // coordinates here are in longitude, latitude order because
        // x, y is the standard for GeoJSON and many formats
        coordinates: [
          longitude, 
          latitude
        ]
    },
    properties: {
        title: 'Current Location',
        // one can customize markers by adding simplestyle properties
        // https://www.mapbox.com/guides/an-open-platform/#simplestyle
        'marker-size': 'large',
        'marker-color': '#15b3d9',
        'marker-symbol': 'star-stroked'
    }
  }).addTo(map);
}

function makeMomentMap(arr){
  L.mapbox.accessToken = 'pk.eyJ1Ijoid2FsdGVyYm0iLCJhIjoiMDU5ODljMDBjNzg3ZThlZTJlMTAwYWRhMTFjYWE0MzUifQ.CJ0ZCaTRHRMJTWDE0kIubA';
  var map = L.mapbox.map('map', 'mapbox.run-bike-hike')
    .setView([parseFloat(arr[arr.length-1][0]), parseFloat(arr[arr.length-1][1])], 13);
  var myLayer = L.mapbox.featureLayer().addTo(map);
  var features = [];
  arr.forEach(function(marker){
    features.push({
      type: 'Feature',
      geometry: {
          type: 'Point',
          coordinates: [parseFloat(marker[1]), parseFloat(marker[0])]
      },
      properties: {
          'marker-color': '#15b3d9',
          'marker-symbol': 'star-stroked',
          description: marker[2]
      }
    });
  })
  
  myLayer.setGeoJSON({
    type: 'FeatureCollection',
    features: features
  });
  
  // leaflet bug hacked
  setTimeout(function () {
    map.fitBounds(myLayer.getBounds());
  }, 0);
}