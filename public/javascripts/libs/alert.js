Mootils.Alert = new Class({
  Implements: [Options, Events],
  options: {
    className: null,
  	styles: null,
  	btns: [ { text: 'close', className: 'red' } ],
  	showTransition: {
  		time: 300,
  		func: Fx.Transitions.Quad.easeOut
  	},
  	hideTransition: {
  		time: 300,
  		func: Fx.Transitions.Sine.easeOut
  	},
  	useOverlay: false,
  	overlayOptions: {}
  },
  initialize: function(str, options){
  	this.message = str;
  	this.index = Mootils.alerts ? Mootils.alerts.length : 0;
    if (typeof(Mootils.Alert.$prototype) !== 'undefined') this.setOptions(Mootils.Alert.$prototype);
    this.setOptions(options);
  	this.evtClick = this.handleClick.bindWithEvent(this);
  	this.evtKeys = this.handleKeyUp.bindWithEvent(this);
  	this.evtScroll = this.handleScroll.bindWithEvent(this);
  	this.evtResize = this.handleResize.bindWithEvent(this);
  	window.addEvent('keyup', this.evtKeys);
  	window.addEvent('scroll', this.evtScroll);
  	return this.create().center().show();
  },
  create: function() {
  	if (this.options.useOverlay) this.overlay = this.overlay || new Mootils.Overlay(this.options.overlayOptions);
  	this.div = new Element('div', {
  		'class': this.options.className,
  		'styles': {
  			'position': 'absolute',
 	    	'white-space': 'nowrap',
  			'opacity': 0,
 	    	'z-index': 8000
  		}
  	}).inject(document.body);
    	
    if (this.options.styles) {
      this.div.setStyles(this.options.styles);
    } else if (!this.options.className) {
      this.div.setStyles({
        'background-color': '#fff',
        'border': '4px solid #ddd',
        'padding': '20px'
      });
    }
    this.p = new Element('p', {
      'html': this.message
  	}).inject(this.div);
  	this.btns = [];
  	var i = this.options.btns.length;
  	while (i--) {  	
    	this.btns.push(  	
      	new Element('button', {
          'text': this.options.btns[i].text,
          'class': 'button ' + (this.options.btns[i].className || 'gray'),
          'styles': {
            'position': 'relative',
            'float': 'right',
            'margin': '0 0 0 7px'
          },
          'events': {
            'click': this.evtClick
          }
      	}).inject(this.div)
    	);
  	}
  	return this;
  },
  center: function() {
  	var alertSize = this.div.getSize();
  	var winSize = window.getSize();
    var winScroll = window.getScroll();
  	this.div.setStyles({
 	    'left': winScroll.x + (winSize.x * 0.5) - (alertSize.x * 0.5),
 	    'top':  winScroll.y + (winSize.y * 0.5) - (alertSize.y * 0.5)
 	  });
 	  return this;
  },
 	show: function(src) {
 	  if (!this.div) this;
 	  window.addEvent('scroll', this.evtScroll);
   	window.addEvent('resize', this.evtResize);
   	this.div.get('tween', { property: 'opacity', duration: this.options.hideTransition.time }).start(1);   	
 	  return this;
 	},
 	hide: function() {
 	  if (!this.div) return this;
 	  if (this.overlay) this.overlay.hide();
 	  this.div.get('tween', { property: 'opacity', duration: this.options.hideTransition.time }).start(0);
  	this.destroy.delay(this.options.hideTransition.time, this);
 		return this;
 	},
 	disableEvents: function() {
 		if (!this.div) return this;
 		var i = this.btns.length;
 		while (i--) this.btns[i].removeEvents();
  	this.div.removeEvent(this.evtKeys);	
  	return this;
 	},
 	destroy: function() {
 		if (!this.div) return this;
 	  else this.div = this.div.destroy();
 	  window.removeEvent('scroll', this.evtScroll);
   	window.removeEvent('resize', this.evtResize);
   	if (0 < this.index)	Mootils.alerts.splice(this.index, 1);
   	return null;
 	},
 	handleClick: function(evt) {
 	  evt = new Event(evt).stop();
 	  var txt = evt.target.get('text');
 	  Debug.trace('CLICK', txt);
 	  this.hide();
 	  this.fireEvent('complete', { text: txt });
 	  return this;
 	},
  handleKeyUp: function(evt) {
 	  switch (evt.key) {
  	case 'esc':
  		this.hide();	
   	  this.fireEvent('complete', { text: 'esc' });
  		break;
    }
 	},
 	handleScroll: function() {
 	  this.center();
  },
 	handleResize: function() {
 	  this.center();
  }
});






Mootils.alerts = [];
Mootils.clearAlert = function() {
  if (Mootils.alerts[0]) {
    Mootils.alerts[0].hide();
    delete Mootils.alerts[0];
    Mootils.alerts.splice(0, 1);
  }
};
Mootils.showAlert = function(msg, opts) {
  Mootils.clearAlert();
  var alert = new Mootils.Alert(msg, opts);
  Mootils.alerts.push( alert );
  return alert;
};


Mootils.alert = function() {
  return Mootils.showAlert(arguments[0], arguments[1] || { className: 'alertBox', btns: [ { text: 'ok', className: 'red' } ] });
};
Mootils.confirm = function() {
  return Mootils.showAlert(arguments[0], arguments[1] || { className: 'confirmBox', btns: [ { text: 'yes', className: 'green' }, { text: 'no', className: 'red' } ] });
};



