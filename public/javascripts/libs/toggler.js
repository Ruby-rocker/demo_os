//- COPYRIGHT 2009 CITRUS MEDIA GROUP -//

if (typeof(Mootils) === 'undefined') throw 'Mootils.Toggler requires the Mootils base.';

Mootils.Toggler = new Class({
  Implements: [Options, Events],
  options: {
    startIndex: 0,
    toggleOver: -1,
    activeClass: 'active',
    cookies: true
  },
  initialize: function(btns, els, options) {
    this.buttons = $type(btns) === 'string' ? $$(btns) : btns;
    this.elements = $type(els) === 'string' ? $$(els) : els;
    this.setOptions(options);
    this.setup();
  },
  setup: function() {
    if (this.options.cookies) this.index = Cookie.read(this.options.id || 'tglr' + 'Index') || this.options.startIndex;
    else this.index = this.options.startIndex;
    this.index = this.index.toInt();
    this.buttons.each(function(el, idx) {
      if (idx === this.index) el.addClass(this.options.activeClass);
      el.addEvent('click', this.handleClick.bindWithEvent(this, idx));
    }.bind(this));
    this.elements.each(function(el, idx){
      if (idx === this.index || idx === this.options.toggleOver) el.setStyle('display', 'block');
      else if (idx !== this.index && idx !== this.options.toggleOver) el.setStyle('display', 'none');
    }.bind(this));
  },
  toggle: function(idx) {
    if (idx === this.index) return this;
    if (this.buttons[this.index]) $(this.buttons[this.index]).removeClass(this.options.activeClass);
    if (this.buttons[idx]) $(this.buttons[idx]).addClass(this.options.activeClass);
    if (this.index !== this.options.toggleOver) $(this.elements[this.index]).setStyle('display', 'none');
    if ($(this.elements[idx]).getStyle('display') !== 'block') $(this.elements[idx]).setStyle('display', 'block');
    this.index = idx;
    if (this.options.cookies) Cookie.write(this.options.id || 'tglr' + 'Index', this.index);
    this.fireEvent('change', this.index);
    return this;
  },
  next: function() {
    return (this.index + 1) < this.elements.length ? this.index + 1 : 0;
  },
  handleClick: function(evt, idx) {
    evt = new Event(evt).stop();
    this.toggle(this.buttons.length === 1 ? this.next() : idx);
  }
});