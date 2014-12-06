OneStory.ResultWindow = {
  show: function(marker) {
    var win = OneStory.ResultWindow.win = (OneStory.ResultWindow.win || new OneStory.ResultWin('locationList'));
    win.update({ subtitle: marker.getTitle() });
  },
  hide: function() {
    var win = OneStory.ResultWindow.win;
    return win ? win.hide() : null;
  }
};


var DisplayObject = new Class({
  show: function() {
    if (!this.div) return this;
    if (!this.isVisible()) this.div.setStyles({ 'opacity': 0, 'display': 'block' });
    this.div.fade(arguments[0] || 1);
    return this;
  },
  hide: function() {
    if (!this.div) return this;
    this.div.fade(0);
    return this;
  },
  toggle: function() {
    return this.isVisible() ? this.hide() : this.show();
  },
  isVisible: function() {
    return this.div ? this.div.getStyle('display') !== 'none' && this.div.getStyle('opacity') !== 0 : false;
  }
});


OneStory.ResultWin = new Class({
  Implements: [Options, Events, DisplayObject],
  options: {
    ids: null,
    title: 'Location',
    subtitle: null,
    results: []
  },
  initialize: function(el, options) { 
    this.div = $(el).set('tween', { duration: 'short' });
    this.setOptions(options);
    this.setup(); 
    
    if (this.options.subtitle) this.update().show();
  },
  setup: function() {
    this.div.set('tween', { duration: '150' });
    this.header = this.div.getFirst('div');
    this.content = this.div.getLast('div');
    
    this.title = this.header.getFirst('h3');
    this.subtitle = this.header.getFirst('h2');
    
    this.btnClose = this.header.getElements('a.close');
    if (this.btnClose) this.btnClose.addEvent('click', function(evt) {
      evt = new Event(evt).stop();
      this.hide();
    }.bind(this));
    return this;
  },
  update: function(options) {
    this.setOptions(options || {});
    
    var url;
    
    if (this.title) this.title.set('text', this.options.title + ':');
    
    if ($type(this.options.ids) == 'array') {
      url = '/stories/in/' + this.options.subtitle;
    }
    
    if (this.options.subtitle) {
      if (this.subtitle) this.subtitle.set('text', 27 < this.options.subtitle.length ? this.options.subtitle.replace(/\s$/, '').substring(0,27) + '...' : this.options.subtitle);
      url = url || '/stories/near/location/?query=' + this.options.subtitle
    }
    
    this.content.empty().load(url);
    if (!this.isVisible()) this.show();
    
    return this;
  }
});