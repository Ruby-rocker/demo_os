var OneStory = {
  init: function(evt) {
    OneStory.StoryLinks.init();
  },
  loaded: function() {
    //OneStory.Maps.hideText.delay(100);
  }
};

OneStory.StoryLinks = {
  init: function() {
    this.win = $(window);
    $$('a.story, a.popup').each(this.add.bind(this));
  },
  add: function(link,index) {
    $(link).addEvent('click', this.readStory.bindWithEvent(this, $(link).get('href')));
  },
  readStory: function(evt, url) {
    evt = new Event(evt).stop();
    this.win.open(url, (url.replace(/(http:)|\//gi, '').trim() + 'Win'), 'status=0,toolbar=1,menubar=0,scrollbars=1,width=820,height=' + (screen.height - 130));
  }
};


OneStory.Maps = {
  hideText: function() {
    var logo = $('logocontrol');
    if (logo && logo.getNext('div')) logo.getNext('div').getFirst('span').setStyle('display', 'none');
  },
  reset: function() {
    this.map = null;
    this.mgr = null;
    return this;
  },
  set: function(map) {
    if (this.map || this.mgr) this.reset();
    this.map = map;    
    this.mgr = new MarkerManager(this.map);
    return this;
  },
  getMap: function() {
    return this.map;
  },
  getManager: function() {
    return this.mgr;
  }
};


OneStory.Markers = {
  getIcon: function(color, density) {
    var minP = 0.45;
    var maxP = 0.725;
    var p = minP + (density-this.minDensity) * ((maxP-minP)/(this.maxDensity-this.minDensity));
    // console.log(density + "," + p)
    var icon = new GIcon();
    p < 2 ? size_x = 15 * p : size_x = 8 * p;



    // size_x < 20 ? icon.iconSize = new GSize(size_x, 24 * p) : icon.iconSize = new GSize(size_x, 10 * p, 6 * p);
    // size_x < 20 ? icon.shadowSize = new GSize(25 * p, 23 * p) : icon.shadowSize = new GSize(19 * p, 17 * p);
    // size_x < 20 ? icon.iconAnchor = new GPoint(6 * p, 22 * p) : icon.iconAnchor = new GPoint(1 * p, 17 * p);



    // size_x < 20 ? icon.iconSize = new GSize(size_x, 24 * p) : icon.iconSize = new GSize(size_x, 15 * p, 10 * p);
    // size_x < 20 ? icon.shadowSize = new GSize(25 * p, 23 * p) : icon.shadowSize = new GSize(19 * p, 17 * p);
    // size_x < 20 ? icon.iconAnchor = new GPoint(6 * p, 22 * p) : icon.iconAnchor = new GPoint(1 * p, 20 * p);
    

    size_x < 30 ? icon.iconSize = new GSize(size_x, 24 * p) : icon.iconSize = new GSize(size_x, 15 * p, 10 * p);
    size_x < 20 ? icon.shadowSize = new GSize(25 * p, 23 * p) : icon.shadowSize = new GSize(19 * p, 17 * p);
    size_x < 20 ? icon.iconAnchor = new GPoint(6 * p, 22 * p) : icon.iconAnchor = new GPoint(1 * p, 20 * p);

    // size_x = 15 * p;
    // icon.iconSize = new GSize(size_x, 24 * p);
    // icon.shadowSize = new GSize(25 * p, 23 * p);
    // icon.iconAnchor = new GPoint(6 * p, 22 * p);

    size_x = size_x.round();
    if (size_x < 20) {
      icon.image = "/images/icons/med_" + color + ".png";
    } else if (size_x < 50) {
      icon.iconSize = new GSize(size_x, 32);
      icon.shadowSize = new GSize(18 * p, 16 * p);
      icon.iconAnchor = new GPoint(3 * p, 12 * p);
      icon.image = "/images/icons/lg_" + color + ".png";
    } else {    
      icon.image = "/images/icons/med_" + color + ".png";
    }    
    return icon;
  },
  createMarker: function(posn, title, icon, density, callback) {
    var marker = new GMarker(posn, {
      title: title,
      icon: OneStory.Markers.getIcon(icon, density),
      draggable: false
    });
    if (callback && typeof(callback) == 'function') {
      GEvent.addListener(marker, 'click', function() {
        callback(marker);
        //OneStory.Markers.showInfo(marker);
        //OneStory.ResultWindow.show(marker);
        
      });
    }
    return marker;
  },
  addMarkers: function(arr, options) {
    options = options || {};
    this.minDensity = 99999999;
    this.maxDensity = 0;
		var highCountPos, highCount = 0;
    var mgr = OneStory.Maps.getManager();
		var geocode, markers = []
		arr = arr || []
		
		// get min and max
		for(i=0,l=arr.length;i<l;i++) {
		  geocode = arr[i].geocode		  
		  if (geocode && $type(geocode) === 'object' && geocode.count) {
		    this.maxDensity = this.maxDensity || geocode.count;
	      this.minDensity = geocode.count < this.minDensity ? geocode.count : this.minDensity;
      }
		}
		if (this.minDensity < 0 || this.minDensity == 99999999) {
		  this.minDensity = 1;
		}
		if (this.maxDensity < 1) {
		  this.maxDensity = 1;
		}
		if (this.minDensity == this.maxDensity) this.minDensity--;
		for(i=0,l=arr.length;i<l;i++) {
		  geocode = arr[i].geocode
		  if (geocode && $type(geocode) === 'object') {
				var title = geocode.query || geocode.title || 'unknown';
				var icon = (options.icon || options.showRecent && i < 50 ? 'green' : 'blue');
        
        if (geocode.count < 3) {
          var density = geocode.count || geocode.showRecent && i < 3 ? 2 : 0;
        }
        if (geocode.count > 3 && geocode.count < 6 ) {
          var density = geocode.count || geocode.showRecent && i < 3 ? 5 : 0;
        }
        if (geocode.count > 6 && geocode.count < 9) {
          var density = geocode.count || geocode.showRecent && i < 3 ? 9 : 0;
        }
        if (geocode.count > 9) {
          var density = geocode.count || geocode.showRecent && i < 3 ? 10 : 0;
        }
				//var density = geocode.count || 1;
				var posn = new GLatLng(geocode.latitude, geocode.longitude);
				//title += ' (' + density + ')';
				if (highCount < density) {
          highCount = density;
				  highCountPos = posn;
				}
				var marker = OneStory.Markers.createMarker(posn, title, icon, density, options.callback);
	      markers.push(marker);
	    }
    }
    mgr.addMarkers(markers, 0, 17);
    mgr.refresh();
    OneStory.Maps.getMap().setCenter(highCountPos);
    return this;
  },
  showInfo: function(marker) {
    OneStory.Maps.getMap().openInfoWindow(marker.getLatLng(), "<h3 style=\"margin: 19px; text-align: center;\">" + marker.getTitle() + "</h3>")
  }
};

OneStory.Locations = {
  getLocations: function() {
    params = arguments[0] && $type(arguments[0]) == 'object' ? arguments[0] : {}
    params = new Hash(params);
    var marker_params = {};
    if (params.icon) {
      marker_params.icon = params.icon;
      delete params.icon
    }
    if (params.showRecent) {
      marker_params.showRecent = params.showRecent;
      delete params.showRecent
    }
    if (params.callback) {
      marker_params.callback = params.callback;
      delete params.callback
    }
    delay = arguments[1] || null;
    req = new Request.JSON({ url: '/geocodes.json', method: 'get' });
    req.addEvent('complete', function(evt) {
      OneStory.Markers.addMarkers(evt, marker_params);
    }.bind(this));
    
    if (delay) req.send.delay(delay, req, params.toQueryString());
    else req.send(params.toQueryString());
    
  }
};


if (typeof(MooTools) !== 'undefined') {
  $(window).addEvent('domready', OneStory.init);
  $(window).addEvent('load', OneStory.loaded);
};