//- COPYRIGHT 2009 CITRUS MEDIA GROUP -//

if (typeof(Mootils) === 'undefined') throw 'Mootils.SlideShow requires the Mootils base.';

Mootils.SlideShow = new Class({
  Implements: [Options, Events],
  options: {
  	delay: 6000,
  	path: '/images/slideshow',
  	fadeDelay: 1000,
    random: true
  },
  initialize: function(container, slides, options) {
    this.div = $(container);
    this.slides = $splat(slides);
    this.setOptions(options);
    this.setup();
    this.play();
  },
  setup: function() {
    if (this.options.random) this.randomize();
    if (!this.initSlide()) this.setIndex(0)
    this.slide_sources = this.slides.filter($lambda(true));
    for(var i = 0, l = this.slides.length; i < l; i++) this.addSlide(this.options.path, this.slides[i], i);
    this.slides[this.index].build().show();
    this.slides[this.nextIndex].build();    
  },
  play: function() {
    this.tInt = this.transition.periodical(this.options.delay, this);
  },
  stop: function() {
    this.index = 0;
    this.tInt = $clear(this.tInt);
  },
  transition: function() {
    this.advance();
    var last = this.slides[this.lastIndex];
    var cur = this.slides[this.index];
    var next = this.slides[this.nextIndex];
    if (last && last.visible()) last.hide();
    if (cur && cur.built()) cur.show();
    if (next) next.build();
  },
  randomize: function() {
    function randomizer(){
      return (Math.round(Math.random())-0.5);
    }
  	this.slides.sort(randomizer);
  	return this;
  },
  addSlide: function(path, image, index) {
    index = $chk(index) ? index : this.slides.length;
    return this.slides[index] = new Mootils.Slide(this, path, image);
  },
  initSlide: function() {
    var bg = this.div.getStyle('background-image');
    var cur = bg && bg.match(/[a-zA-Z0-9\s_-]+\.(jpg|JPG)/) ? bg.match(/[a-zA-Z0-9\s_-]+\.(jpg|JPG)/)[0] : null;
    if (cur) {
      if (this.slides.indexOf(cur) < 0) this.index = this.slides.push(cur);
      else this.setIndex(this.slides.indexOf(cur))
    }
    return cur !== null;
  },
  setIndex: function(index) {
    this.index = index < this.slides.length ? index : 0;
    this.lastIndex = 0 < (this.index - 1) ? this.index - 1 : this.slides.length - 1;
    this.nextIndex = (this.index + 1) < this.slides.length ? this.index + 1 : 0;
  },
  advance: function() {
    this.setIndex(this.index + 1);
    return this;
  }
});
Mootils.Slide = new Class({
  initialize: function(slideshow, path, image) {
    this.parent = slideshow;
    this.path = path;
    this.image = image;
  },
  build: function() {
    if (this.div) return this;
    var s = this.parent.div.getSize();
    this.div = new Element('div', {
      'styles': {
        'position': 'absolute',
        'left': 0,
        'top': 0,
        'width': s.x,
        'height': s.y,
        'background': 'transparent url(' + this.path + '/' + this.image + ') 0 0 no-repeat',
        'opacity': 0,
        'z-index': 0
      }
    }).inject(this.parent.div);
    return this;
  },
  show: function() {
    if (!this.div) throw "Mootils.Slide must be built before showing";
    else {
      this.div.setStyle('z-index', 4000).get('tween', { property: 'opacity', duration: this.parent.options.fadeDelay }).start(1);
    }
    return this;
  },
  hide: function() {
    if (!this.div) throw "Mootils.Slide must be built before hiding";
    else {
      this.div.get('tween', { property: 'opacity', duration: this.parent.options.fadeDelay, onComplete: function(){
        this.div.setStyle('z-index', 0);
      }.bind(this)}).start(0);
    }
    return this;
  },
  visible: function() {
    return (this.built() && 0.5 < this.div.getStyle('opacity'));
  },
  built: function() {
    return (this.div && $type(this.div) === 'element');
  }
});
