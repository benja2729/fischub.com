var __hasProp = {}.hasOwnProperty;

define(['ember', 'mixins/jquery-plugin', 'lib/bootstrap', 'templates'], function(Ember, JQ) {
  var defaultKeys, key;
  defaultKeys = (function() {
    var _ref, _results;
    _ref = Ember.$.fn.modal.defaults;
    _results = [];
    for (key in _ref) {
      if (!__hasProp.call(_ref, key)) continue;
      _results.push(key);
    }
    return _results;
  })();
  return Ember.View.extend(JQ, {
    init: function() {
      return this._super();
    },
    tagName: 'article',
    templateName: 'modal',
    classNames: ['modal'],
    classNameBindings: ['animate:fade:', 'show:show:hide'],
    animate: true,
    header: 'test header',
    body: 'test body',
    footer: 'test footer',
    jqDefaults: Ember.$.fn.modal.defaults,
    jqueryElement: null,
    willInsertElement: function() {
      var el, props;
      console.log('In ModalView');
      el = Ember.$(this.get('element'));
      props = Ember.$.extend({}, Ember.$.fn.modal.defaults, this.getProperties(defaultKeys));
      el.modal(props);
      this.set('jqueryElement', el);
      return this._super();
    },
    willDestroyElement: function() {
      var el;
      el = Ember.$(this.get('element'));
      return el.off().removeData();
    }
  });
});
