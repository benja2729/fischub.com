
require.config
  baseUrl: 'js/'

  paths:
    'jquery': '//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min'
    'ember': 'lib/ember'
    'ember.bootstrap': 'lib/ember-bootstrap'

  shim:
    'ember':
      deps: ['lib/handlebars', 'jquery']
      exports: 'Ember'

    # Bootstrap plugins defined in Gruntfile
    # Defines commonly used plugins
    #
    # Probably should look to use requirejs optimzer to
    #   wrap this in AMD syntax
    'lib/bootstrap':
      deps: ['jquery']

    'templates':
      deps: ['ember']

define [
  'ember', 'views/ModalView'
  'lib/bootstrap', 'templates'
  ], (Ember, ModalView) ->

  window.Site = Site = Ember.Application.create
    title: 'Fischub'
    copyright: "© Fischub #{(new Date()).getFullYear()}"

  # TODO: Set-up contact modal as if it were the contact page but inside a modal
  Site.ContactView = ModalView.extend()
  Site.ModalTrigger = Ember.View.extend
    click: ->
      modal = @get 'modal'
      if Ember.isEmpty(modal)
        modal = ModalView.create()
        @set 'modal', modal
        console.log 'before append'
        modal.append()
        console.log 'after append'
      else
        Ember.$(modal.get('element')).modal('toggle')

  Site.Router.map ->
    @resource 'about'
    @route 'contact'