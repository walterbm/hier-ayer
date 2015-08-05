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
        title: 'Flatiron School',
        description: '11 Broadway, New York',
        // one can customize markers by adding simplestyle properties
        // https://www.mapbox.com/guides/an-open-platform/#simplestyle
        'marker-size': 'large',
        'marker-color': '#FF0066',
        'marker-symbol': 'danger'
    }
  }).addTo(map);
}

function makeMomentMap(arr){
  L.mapbox.accessToken = 'pk.eyJ1Ijoid2FsdGVyYm0iLCJhIjoiMDU5ODljMDBjNzg3ZThlZTJlMTAwYWRhMTFjYWE0MzUifQ.CJ0ZCaTRHRMJTWDE0kIubA';
  var map = L.mapbox.map('map', 'mapbox.run-bike-hike');
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
          'marker-color': '#000',
          'marker-symbol': 'star-stroked',
          title: [marker[0], marker[1]].join(',')
      }
    });
  })
  
  myLayer.setGeoJSON({
    type: 'FeatureCollection',
    features: features
  });
}