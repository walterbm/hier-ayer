
function makeMap(latitude, longitude){
  L.mapbox.ENV["access_token"];
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

