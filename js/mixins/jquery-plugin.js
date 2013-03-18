var __hasProp = {}.hasOwnProperty;

define(['ember', 'jquery'], function(Ember, $) {
  var getKeys;
  getKeys = function(obj) {
    var key, _results;
    console.log('in getKeys: ', arguments);
    _results = [];
    for (key in obj) {
      if (!__hasProp.call(obj, key)) continue;
      _results.push(key);
    }
    return _results;
  };
  return Ember.JQ = Ember.Mixin.create({
    init: function() {
      this._super();
      return this.get('concatenatedProperties').push('jqOptions');
    },
    jqOptions: [],
    jqDefaultsList: getKeys.property('jqDefaults'),
    willInsertElement: function() {
      var options;
      this._super();
      return options = this._attachOptions();
    },
    willDestroyElement: function() {
      var observers, prop, ui;
      ui = this.get('ui');
      if (ui) {
        observers = this._observers;
        for (prop in observers) {
          if (!__hasProp.call(observers, prop)) continue;
          this.removeObserver(prop, observers[prop]);
        }
        return ui._destroy();
      }
    },
    _attachOptions: function() {
      var jqOptions, key, observer, options, value;
      jqOptions = this.get('jqOptions');
      options = {};
      for (key in jqOptions) {
        if (!__hasProp.call(jqOptions, key)) continue;
        value = this.get(key);
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
    _gatherEvents: function(options) {
      var uiEvents,
        _this = this;
      uiEvents = this.get('uiEvents' || {});
      return uiEvents.forEach(function(event) {
        var callback;
        callback = _this[event];
        if (callback) {
          return options[event] = function(event, ui) {
            return callback.call(_this, event, ui);
          };
        }
      });
    }
  });
});
