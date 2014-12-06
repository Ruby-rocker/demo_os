// COPYRIGHT 2009 - CitrusMediaGroup - All Rights Reserved
Mootils.FormValidator = new Class({
  initialize: function(form) {
    this.formName = form;
    $(this.formName).addEvent('submit', this.handleSubmit.bind(this));
  },
  validate: function() {
    Mootils.Validator.reset();
    this.fields = $$('#' + this.formName + ' .required');
    if (!this.fields) return false;
    var i = this.fields.length;
    while(i--) {
      var t = 'text', a = this.fields[i].get('class').split(' ');
      var j = a.length;
      while(j--) t = Mootils.Validator.types.contains(a[j]) ? a[j] : t;
      Mootils.Validator.checkValid(this.fields[i], t);
    }
    
    this.optional_fields = $$('#' + this.formName + ' .optional');
    i = this.optional_fields.length;
    while(i--) {
    	if (0 < this.optional_fields[i].get('value').length) {
	    	var t = 'text', a = this.optional_fields[i].get('class').split(' ');
	      var j = a.length;
	      while(j--) t = Mootils.Validator.types.contains(a[j]) ? a[j] : t;
	      Mootils.Validator.checkValid(this.optional_fields[i],t);
      }
    }
    return Mootils.Validator.isValid();
  },
  handleSubmit: function(evt) {
  	if (!this.validate()) evt = new Event(evt).stop();
  }
});

Mootils.Validator = {
  errors: [],
  types: [ 'number', 'zipcode', 'price', 'phone', 'photo', 'image/gif', 'image/jpeg', 'image/png', 'email', 'url' ],
  hasLength: function() {
    return Boolean(0 < $(arguments[0]).get('value').length);
  },  
  checkValid: function() {
    var _el = $(arguments[0]);
    var _return = true;
    if (!_el) return false;
    var _val = _el.get('value').replace(/\s/g, '');
    if (!_val || _val.length === 0) _return = false;
    else if (_el.get('type') === 'checkbox') _return = _el.get('checked');
   	else if (arguments[1]) {
      var regex, _type;
      if ($type(arguments[1]) === 'regex') regex = arguments[1];
      else if ($type(arguments[1]) === 'string') {
         _type = arguments[1];
         switch(_type) {
            case 'number':
              regex = /^[0-9]*$/;
              break;
            case 'zipcode':
              regex = /^[0-9]{5}$/;
              break;
            case 'price':
              regex = /^\$\d{1,3}(,\d\d\d)*\.\d\d$|^\$?\d+\.\d\d$/;
              break;
            case 'phone':
              regex = /(1\s*[-\/\.]?)?(\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(([xX]|[eE][xX][tT])\.?\s*(\d+))*$/;
              break;
            case 'photo':
              regex = /[^\.exe]?[a-zA-Z0-9\s_-]+\.(jpg|JPG|png|PNG|gif|GIF)$/;
              break;
            case 'image/gif':
              regex = /[^\.exe]?[a-zA-Z0-9\s_-]+\.(gif|GIF)$/;
              break;
            case 'image/jpg':
            case 'image/jpeg':
              regex = /[^\.exe]?[a-zA-Z0-9\s_-]+\.(jpg|JPG)$/;
              break;
            case 'image/png':
              regex = /[^\.exe]?[a-zA-Z0-9\s_-]+\.(png|PNG)$/;
              break;
            case 'date':
              if (!typeof(Date.CultureInfo) !== 'undefined') _return = Date.parse(_val) !== null;
              else Debug.trace('Required library date.js not found!');
              break;
            case 'email':
              regex = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+){0,10}@([a-z0-9_]{1,40}(\.[-a-z0-9_]{1,40})*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;
              break;           
            case 'url':
            	regex = /^(http)(s?)\:\/\/[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*(\/?)([a-zA-Z0-9\-\.\?\,\'\/\\\+&amp;=:%\$#_]*)?/;
            	break;	
            }
      }
      if (regex) _return = _val.test(regex);
      if (_return === true && arguments[2] && $type(arguments[2]) === 'object') {
        var args = arguments[2];
        switch(_type) {
          case 'number':
            _val = Number(_val);
            if (args.min) _return = Boolean(args.min <= _val);
            if (args.max) _return = Boolean(_val <= args.max); 
            break;  
        }
      }
      
    }
      
    if (_return === false) {
      if (_el.get('type') !== 'hidden') Mootils.Validator.showInvalid(_el);
      return false;
    } else return true;
  },
  showInvalid: function(el) {
    el = $(el);
    if (!el) return false;
    var icn = new Mootils.ErrorIcon().alignWith( el.get('type') === 'checkbox' ? { alignWith: el, coords: { x: -21 }} : el );
    this.errors.push(icn);
    return true;
  },
  clear: function(i) {
    if (!this.errors || !this.errors[i]) return false;
    this.errors[i].clear();
    this.errors.splice(i, 1);
    return true;
  },
  reset: function() {
    if (this.errors) {
      if (0 < this.errors.length) {
        var i = this.errors.length;
        while (i--) Mootils.Validator.clear(i);
      }
    }
    this.errors = new Array();
    return true;
  },
  isValid: function() {
    return this.errors.length === 0;
  }
};


Mootils.ErrorIcon = new Class({
  Implements: Options,
  options: {
  	align: 'right',
    alignWith: null,
    size: 21,
    margin: 5,
    src: '/images/error_icon.png'
  },
  initialize: function(options) {
    if (typeof(Mootils.ErrorIcon.$prototype) !== 'undefined') this.setOptions(Mootils.ErrorIcon.$prototype);
    this.setOptions(options);
    this.create();
  },
  create: function() {
    this.div = new Element('div', {
      'styles': {
        'position': 'absolute',
        'width': this.options.size,
        'height': this.options.size,
        'background': 'transparent url(' + this.options.src + ') 0 0 no-repeat',
        'z-index': 7900
      }
    });
    return this;
  },
  alignWith: function() {
  	if ($chk(arguments[0])) {
  		this.options.alignWith = null;
	  	this.options.coords = null;
  		switch ($type(arguments[0])) {
  			case 'element':
  			case 'string':
  				this.options.alignWith = arguments[0];
  				break;
  			case 'number':
  				this.options.coords = { x: arguments[0], y: arguments[1] ? arguments[1] : arguments[0] };
  				break;
  			case 'array':
  				this.options.coords = { x: arguments[0][0], y: arguments[0][1] };
  				break;
  			case 'object':
  				var obj = arguments[0];
	  			this.options.alignWith = obj.alignWith || null;
	  			this.options.coords = obj.coords || null;
	  			if (!this.options.alignWith && !this.options.coords) return false;
  				break;
  		}
  	}
  	
  	this.options.alignWith = $(this.options.alignWith);
  	this.options.parent = this.options.parent ? $(this.options.parent) : (this.options.alignWith ? this.options.alignWith.getParent() : document.body ); 	
     
   	if (this.options.coords) this.div.setStyles({left: this.options.coords.x, top: this.options.coords.y});
 		else if (this.options.alignWith) {
 			var left, coords = this.options.alignWith.getCoordinates(this.options.parent);
 			switch (this.options.align) {
       	case 'left': 
   		    left = coords.left - this.options.size - this.options.margin;
   		    break;
   		  case 'right':
   		  	left = coords.left + coords.width + this.options.margin;
   		  	break;
       }
 			this.div.setStyles({left: left, top: coords.top + (coords.height * 0.5) - (this.options.size * 0.5) });
 		}
 		this.options.parent.adopt(this.div);
    this.aligned = true;
  	return this;
  },
  clear: function() {
    if (this.div) this.div = this.div.destroy();
    this.element = null;
  }
});