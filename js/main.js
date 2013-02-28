
require.config({
  baseUrl: 'js/',
  shim: {
    'ember': {
      deps: ['handlebars', 'jquery'],
      exports: 'Ember'
    },
    'templates': {
      deps: ['ember']
    }
  },
  paths: {
    'jquery': '//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min',
    'handlebars': 'lib/handlebars',
    'ember': 'lib/ember',
    'templates': './templates'
  }
});

define(['ember', 'templates'], function(Ember) {
  var Site;
  window.Site = Site = Ember.Application.create({
    title: 'Fischub',
    copyright: "© Fischub " + ((new Date()).getFullYear())
  });
  return Site.Router.map(function() {
    this.resource('about');
    return this.resource('contact');
  });
});
