
require.config
  baseUrl: 'js/'

  shim:
    'ember':
      deps: ['handlebars', 'jquery']
      exports: 'Ember'

    'templates':
      deps: ['ember']

  paths:
    'jquery': '//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min'
    'handlebars': 'lib/handlebars'
    'ember': 'lib/ember'
    'templates': './templates'

define ['ember', 'templates'], (Ember) ->

  window.App = App = Ember.Application.create()