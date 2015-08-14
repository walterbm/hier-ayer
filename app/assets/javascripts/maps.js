L.mapbox.accessToken = 'pk.eyJ1Ijoid2FsdGVyYm0iLCJhIjoiMDU5ODljMDBjNzg3ZThlZTJlMTAwYWRhMTFjYWE0MzUifQ.CJ0ZCaTRHRMJTWDE0kIubA';

function MakeMap(url,page,map_number){
  var self = this;
  self.page = page;
  self.url = url;

  // set default argument
  if (typeof(map_number)==='undefined'){ self.map_number = false; } 
  else{self.map_number = map_number;}
  pageFunctions = {
    'map#show' : self.mapShowPage,
    'welcome#index' : self.welcomeIndexPage,
    'user#show' : self.userShowPage,
    'minimap' : self.minimaps
  };
  pageFunctions[page](self);
}

MakeMap.prototype.mapShowPage = function(self){
  self.map = L.mapbox.map('map', 'mapbox.run-bike-hike',{
    scrollWheelZoom: false,
    compact: true,
    animate: true,
    maxZoom: 20
  }).setView([0,0],1);

  self.myLayer = L.mapbox.featureLayer().addTo(self.map);

  self.getData(self.url, function(){
    self.addMapShowContent();
    self.animateLine();
    self.attachMapShowListeners();
  });
  
};

MakeMap.prototype.welcomeIndexPage = function(self){
  self.map = L.mapbox.map('map', 'mapbox.light',{
    scrollWheelZoom: false,
    compact: true,
    animate: true,
    maxZoom: 20
  }).setView([0,0],1);

  self.myLayer = L.mapbox.featureLayer();
  self.heat = L.heatLayer([], { maxZoom: 12 }).addTo(self.map);

  self.getData(self.url, function(){
    self.heatMap();
  });
};

MakeMap.prototype.userShowPage = function(self){
  self.map = L.mapbox.map('map', 'mapbox.run-bike-hike',{
    scrollWheelZoom: false,
    compact: true,
    animate: true,
    maxZoom: 20
  }).setView([0,0],1);

  self.myLayer = L.mapbox.featureLayer().addTo(self.map);
  self.myMomentLayer = L.mapbox.featureLayer().addTo(self.map);

  self.getData(self.url, function(){
    self.addUserShowContent();
    self.attachUserShowListeners();
    self.attachUserShowJqueryListeners();
  });
};

MakeMap.prototype.minimaps = function(self){
  self.map = L.mapbox.map('map-'+self.map_number, 'mapbox.run-bike-hike',{
    scrollWheelZoom: false,
    zoomControl: false,
    doubleClickZoom: false,
    touchZoom: false,
    dragging: false,
    compact: true,
    animate: true,
    maxZoom: 20
  }).setView([0,0],1);

  self.myLayer = L.mapbox.featureLayer().addTo(self.map);

  self.getData(self.url, function(){
    self.animateLine();
    self.blockPopups();
  });
};


MakeMap.prototype.getData = function(url,callback){
  var self = this;
  $.get(url, function(data) {
    if (data.length === 0) {
      getCoordinates(function(latitude,longitude){
        self.map.setView([latitude,longitude],13);
      });
    }
    else{
      self.myLayer.setGeoJSON({
        type: 'FeatureCollection',
        features: data
      });
      self.fitView();
      callback();
    }
  });
};

MakeMap.prototype.fitView = function(){
  var self = this;
  setTimeout(function () { self.map.fitBounds(self.myLayer.getBounds()); }, 0);
};

MakeMap.prototype.animateLine = function(){
  var self = this;
  var polyline_options = {color: '#15b3d9', opacity: 0.85};
  var polyline = L.polyline([], polyline_options).addTo(self.map);
  var line = [];
  self.myLayer.eachLayer(function(marker){
    line.push(marker.getLatLng());
  });
  var i = 0;
  function add() {
      polyline.addLatLng(L.latLng(line[i]));
      // change the second argument in setTimeout to adjust speed of animation
      if (++i < line.length) window.setTimeout(add, 1000);
  }
  add();
};

MakeMap.prototype.addMapShowContent = function(){
  var self = this;
  self.myLayer.eachLayer(function(layer) {
    var content;
    if(layer.feature.properties.image === null){
      content = '<h1>'+ layer.feature.properties.description +'<\/h1>';
    }
    else{
      content = '<img src="'+ layer.feature.properties.image+'" alt="" style="width:100%;height:100%">' + '<p>'+ layer.feature.properties.description +'<\/p>';
    }
    layer.bindPopup(content,{
      minWidth: 250
    });
    layer.on('click', function(e){
      layer.openPopup();
      self.map.setView(e.latlng, 15);
    });
  });
};

MakeMap.prototype.addUserShowContent = function(){
  var self = this;
  self.myLayer.eachLayer(function(layer) {
    var content;
    if(layer.feature.properties.image === null){
      content = '<h1><b>' + layer.feature.properties.title + '</b></h1>' + '<p>'+ layer.feature.properties.description +'</p>';
    }
    else{
      content = '<h1><b>' + layer.feature.properties.title + '</b></h1>' + '<img src="'+ layer.feature.properties.image+'" alt="" style="width:100%;height:100%">' + '<p>'+ layer.feature.properties.description +'</p>';
    }
    layer.bindPopup(content,{
      minWidth: 250
    });
    layer.on('click', function(e){
      layer.openPopup();
      self.map.setView(e.latlng, 15);
    });
  });
};

MakeMap.prototype.attachMapShowListeners = function(){
  var self = this;
  self.map.on('click', function(e) {
    self.map.fitBounds(self.myLayer.getBounds());
  });
  self.myLayer.on('mouseover', function(e) {
    e.layer.openPopup();
  });
  self.myLayer.on('mouseout', function(e) {
    e.layer.closePopup();
  });
};

MakeMap.prototype.attachUserShowListeners = function(){
  var self = this;
  self.map.on('click', function(e) {self.map.fitBounds(self.myLayer.getBounds());});
  self.myLayer.on('mouseover', function(e) {e.layer.openPopup();});
  self.myLayer.on('mouseout', function(e) {e.layer.closePopup();});
  self.myMomentLayer.on('mouseover', function(e) {e.layer.openPopup();});
  self.myMomentLayer.on('mouseout', function(e) {e.layer.closePopup();});
};

MakeMap.prototype.attachUserShowJqueryListeners = function(){
  var self = this;
  $('.minimap').mouseover(function(){
    this.style.opacity = "1";
    var mapId = parseInt(this.id.replace("map-", ""));
    $.get("/maps/" + mapId + "/geojson" , function(data) {
      data.forEach(function(moment){
        self.myMomentLayer.setGeoJSON({
          type: 'FeatureCollection',
          features: data
        });
        self.myMomentLayer.eachLayer(function(layer) {
          layer.setIcon(L.mapbox.marker.icon({
              'marker-color': '#ffc04c',
              'marker-symbol': 'star-stroked'
          }));
        });
        self.myMomentLayer.eachLayer(function(layer) {
          var content;
          if(layer.feature.properties.image === null){
            content = '<h2>'+ layer.feature.properties.description +'<\/h2>';
          }
          else{
            content = '<img src="'+ layer.feature.properties.image+'" alt="" style="width:100%;height:100%">' + '<p>'+ layer.feature.properties.description +'<\/p>';
          }
          layer.bindPopup(content,{
            minWidth: 250
          });
          layer.on('click', function(e){
            layer.openPopup();
            self.map.setView(e.latlng, 15);
          });
        });
      });
    });
  });
  
  $('.minimap').mouseleave(function(){
    this.style.opacity = "0.5";
    self.map.removeLayer(self.myMomentLayer);
    self.myMomentLayer = L.mapbox.featureLayer().addTo(self.map);
  });
};

MakeMap.prototype.heatMap = function(){
  var self = this;
  var heat = L.heatLayer([], { maxZoom: 12 }).addTo(self.map);
  self.myLayer.eachLayer(function(l) {
    self.heat.addLatLng(l.getLatLng());
  });
};

MakeMap.prototype.blockPopups = function(){
  var self = this;
  self.myLayer.on('click', function(e) {
     e.layer.closePopup();
     self.map.fitBounds(self.myLayer.getBounds());
  });
};
