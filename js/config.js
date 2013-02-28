
require.config({
  baseUrl: 'js/',
  shim: {
    'ember': {
      deps: ['handlebars', 'jquery'],
      exports: 'Ember'
    }
  },
  paths: {
    'jquery': '//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min',
    'handlebars': 'lib/handlebars',
    'ember': 'lib/ember.js'
  }
});
