//- COPYRIGHT 2009 CITRUS MEDIA GROUP -//
Mootils.AutoFieldset = new Class({
  Implements: [Options],
  
  options: {
    cls: 'autoField',
    max: 5,
    template: null,
    countField: null
  },
  initialize: function(fieldset, options) {
    this.fieldset = $(fieldset);
    this.setOptions(options);
    this.setup().setTrigger().addEvents();
  },
  setup: function() {
    this.parent = this.fieldset.getParent();
    this.fieldsets = this.parent.getChildren('fieldset');
    this.evtKeys = this.handleKeyUp.bindWithEvent(this);
    return this;
  },
  addEvents: function() {
    if (this.triggerField) this.triggerField.addEvent('keyup', this.evtKeys);
    return this;
  },
  removeEvents: function() {
    if (this.triggerField) this.triggerField.removeEvent('keyup', this.evtKeys);
    return this;
  },
  addFieldset: function() {
    this.removeEvents().clearTrigger();
    this.fieldset = new Element('fieldset', { 'id': this.setParagraphId(this.fieldset.get('id')), 'html': this.getHTML() }).inject(this.parent);
    this.setTrigger(true).addEvents();
    this.fieldsets.push(this.fieldset);
    if (this.options.countField && $(this.options.countField)) $(this.options.countField).set('value', this.getCount());
    return this;
  },
  getCount: function() {
    return this.fieldsets.length || 0;
  },
  getHTML: function() {
		return this.setId($(this.options.template || this.fieldset).get('html'));
  },
  setId: function(str) {
    if (this.options.template) return str.replace(/(template)/g, this.getCount()).replace(/(class\=\"\")/, 'class="' + this.options.cls + '"');
    else return str.replace(/(\[[0-9]{1,})/g, '[new').replace(/(\_[0-9]{1,})/g, ('_new_' + this.getCount())).replace(/(class\=\"\")/, 'class="' + this.options.cls + '"');
  },
  setParagraphId: function(str) {
    return str.replace(/(\_[0-9]{1,})/g, ('_' + this.getCount()));
  },
  setTrigger: function() {
    this.triggerField = $$('#' + this.fieldset.get('id') + ' .' + this.options.cls);
    if (arguments[0]) this.triggerField.set('value', '');
    return this;
  },
  clearTrigger: function() {
    this.triggerField.removeClass(this.options.cls);
    this.triggerField = null;
    return this;
  },
  handleKeyUp: function(evt) {
    var txt = evt.target.get('value').clean();
    if (txt.length && this.fieldsets.length <= this.options.max) this.addFieldset();
  }
});