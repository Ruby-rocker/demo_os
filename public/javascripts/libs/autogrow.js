//- COPYRIGHT 2009 CITRUS MEDIA GROUP -//
Mootils.AutoGrow = new Class({
  Implements: [Options],
  options: {
    delay: 1000,
    minHeight: 0,
  	maxCharacters: 8000
  },
  initialize: function(els, options) {
    this.selector = els;
    this.setOptions(options);
    this.setup().initSize();
  },
  setup: function() {
    this.div = this.div ? this.div.empty() : new Element('div', { 'styles': { 'position': 'absolute', 'left': -9999, 'top': -9999, 'border': '1px solid red' }}).inject(document.body);
    this.fields = $$(this.selector);
    this.fields.each(function(el,idx) {
      this.add(el);
    }.bind(this));
    return this;
  },
  initSize: function() {
    this.fields.each(function(el,idx) {      
      this.div.empty().setStyles(el.getStyles('font-size', 'line-height', 'padding')).setStyle('width', el.getWidth()).inject(document.body);
      var h = this.getHeight(el);
      el.setStyle('height', h);
    }.bind(this));
    return this;
  },
  add: function(el) {
    el.setStyle('overflow', 'hidden');
    el.addEvent('focus', function(evt) {
      this.start(el);
    }.bind(this));
    el.addEvent('blur', function(evt) {
      this.stop();
    }.bind(this));
    return this;
  },
  start: function(focus) {
    if (this.checkInt) return false;
    this.cH = 0;
    this.mH = 0;
    this.focus = $(focus);
    if (!this.focus.retrieve('minHeight')) {
      this.mH = this.options.minHeight || ($type(this.focus.getStyle('height').toInt() === 'number') ? this.focus.getStyle('height').toInt() : this.focus.getSize().x);
      this.focus.store('minHeight', this.mH);
    } else this.mH = this.focus.retrieve('minHeight');
    this.div.empty().setStyles(this.focus.getStyles('width', 'font-size', 'line-height', 'padding')).inject(document.body);
    this.checkInt = this.check.periodical(this.options.delay, this);
    return this;
  },
  stop: function() {
    if (this.focus && this.checkInt) {
      this.checkInt = $clear(this.checkInt);
    }
    this.div.dispose();
    return this;
  },
  check: function() {
    var h = this.getHeight(this.focus);
    if (h !== this.cH) {
      this.fx = this.focus.get('tween', { duration: 200, onComplete: function(evt) { this.fx = null; }.bind(this)}).start('height', h);    
      this.cH = h;
    }
    return this;
  },
  getHeight: function(el) {
    var val = el.get('value');
    if (this.options.maxCharacters < val.length) {
      val = val.substring(0, this.options.maxCharacters);
      el.set('value', val);
    }
    this.div.set('html', val.length ? val.replace(/(<|>)/g, '').replace(/\n/g, '<br/>>') : '>');
    var h = this.div.getSize().y + el.getStyle('font-size').toInt();
    h = h < this.mH ? this.mH : h;
    return h;
  }
});