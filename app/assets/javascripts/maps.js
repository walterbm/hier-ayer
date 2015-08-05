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
        'marker-color': '#15b3d9',
        'marker-symbol': 'danger'
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
          title: [marker[0], marker[1]].join(',')
      }
    });
  })
  
  myLayer.setGeoJSON({
    type: 'FeatureCollection',
    features: features
  });
  
  setTimeout(function () {
    map.fitBounds(myLayer.getBounds());
  }, 0);
//  map.on('move', function() {
//    // Construct an empty list to fill with onscreen markers.
//    var inBounds = [],
//    // Get the map bounds - the top-left and bottom-right locations.
//    bounds = map.getBounds();
//
//    // For each marker, consider whether it is currently visible by comparing
//    // with the current map bounds.
//    myLayer.eachLayer(function(marker) {
//      if (bounds.contains(marker.getLatLng())) {
//          inBounds.push(marker.options.title);
//      }
//    })
//
//    // Display a list of markers.
////    document.getElementById('coordinates').innerHTML = inBounds.join('\n');
//  })
}