var __hasProp = {}.hasOwnProperty;

define(['ember', 'jquery'], function(Ember, $) {
  var Core, getKeys;

  getKeys = function(obj) {
    var key, _results;

    _results = [];
    for (key in obj) {
      if (!__hasProp.call(obj, key)) continue;
      _results.push(key);
    }
    return _results;
  };
  Core = Ember.Mixin.create({
    init: function() {
      var opts;

      this._super();
      opts = this.get('jqOptions');
      if ($.isEmptyObject(opts)) {
        return this.set('jqOptions', opts);
      }
    },
    _jqDefaults: {},
    _jqOptions: {},
    _jqEvents: [],
    concatenatedProperties: ['_jqEvents'],
    jqElement: (function() {
      return $(this.get('element'));
    }).property('element'),
    jqOptions: (function(key, value) {
      var defaults, opts;

      opts = this.get('_jqOptions');
      if (value !== void 0) {
        defaults = this.get('_jqDefaults');
        opts = Ember.Object.create($.extend({}, defaults, opts, value));
        this.set('_jqOptions', opts);
      }
      return opts;
    }).property('_jqOptions'),
    jqEvents: (function() {
      var events, key, ret, value;

      events = this.getProperties(this.get('_jqEvents'));
      ret = {};
      for (key in events) {
        if (!__hasProp.call(events, key)) continue;
        value = events[key];
        if (value !== void 0) {
          ret[key] = value;
        }
      }
      return ret;
    }).property('_jqEvents'),
    willInsertElement: function() {
      this._super();
      return this._attachEvents();
    },
    willDestroyElement: function() {
      var el, events;

      this._super();
      el = this.get('jqElement');
      events = this.get('_jqEvents');
      return el.off(events.join(' '));
    },
    _attachOptions: function() {
      var jqOptions, key, observer, options, value;

      jqOptions = this.get('jqOptions');
      options = {};
      for (key in jqOptions) {
        if (!__hasProp.call(jqOptions, key)) continue;
        value = jqOptions[key];
        options[key] = value;
        observer = function() {
          return this.get('ui')._setOption(key, value);
        };
        this.addObserver(key, observer);
        this._observers = this._observers || {};
        this._observers[key] = observer;
      }
      return options;
    },
    _attachEvents: function() {
      var el, event, events, _i, _len, _results,
        _this = this;

      events = this.get('_jqEvents');
      el = this.get('jqElement');
      _results = [];
      for (_i = 0, _len = events.length; _i < _len; _i++) {
        event = events[_i];
        _results.push(el.on(event, function(event) {
          return _this.trigger(event.type);
        }));
      }
      return _results;
    }
  });
  Ember.JQ = Ember.JQ || {};
  return Ember.JQ.Core = Core;
});
