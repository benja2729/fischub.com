
require.config
  baseUrl: 'js/'

  paths:
    'jquery': '//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min'
    'ember': 'lib/ember'

  shim:
    'ember':
      deps: ['lib/handlebars', 'jquery']
      exports: 'Ember'

    'templates':
      deps: ['ember', 'lib/handlebars']

require [
  'ember', 'mixins/JQ/Modal'
  'templates'
  ], (Ember, JQModal) ->

  window.Site = Site = Ember.Application.create
    title: 'Fischub'
    copyright: "© Fischub #{(new Date()).getFullYear()}"

  Site.ContactView = Ember.View.extend JQModal,
    # init: ->
    #   @_super()
    #   window.modal = this
    templateName: 'modal'
    close: -> @get('jqElement').modal('hide')
    show: -> console.log 'showing'
    hidden: -> @destroy()
    header: 'Header Text'
    body: 'Body Text'

  # TODO: Set-up contact modal as if it were the contact page but inside a modal
  Site.ModalTrigger = Ember.View.extend
    init: ->
      @_super()
      modal = Ember.View.createWithMixins JQModal,
        templateName: 'modal'
        jqOptions:
          show: false
        animate: true
        show: -> console.log 'ModalTrigger->show has been fired'
        shown: -> console.log 'ModalTrigger->shown go boom!'
        hide: -> console.log 'hide'
        hidden: -> console.log 'hidden'
        header: 'Header Text'
        body: 'Body Text'
      @set 'modal', modal
      window.modal = modal
      modal.append()

    click: -> @get('modal').get('jqElement').modal 'toggle'

  Site.Router.map ->
    @resource 'about'
    @route 'contact'