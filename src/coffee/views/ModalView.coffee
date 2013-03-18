
define [
  'ember', 'mixins/jquery-plugin'

  'lib/bootstrap', 'templates'
], (Ember, JQ) ->

  defaultKeys = (key for own key of Ember.$.fn.modal.defaults)

  Ember.View.extend JQ,
    init: ->
      @_super()
    tagName: 'article'
    templateName: 'modal'
    classNames: ['modal']
    classNameBindings: ['animate:fade:', 'show:show:hide']
    animate: true
    header: 'test header' #null
    body: 'test body' #null
    footer: 'test footer' #null

    jqDefaults: Ember.$.fn.modal.defaults

    jqueryElement: null
    willInsertElement: ->
      console.log 'In ModalView'
      el = Ember.$(@get 'element')
      props = Ember.$.extend {}, Ember.$.fn.modal.defaults, @getProperties(defaultKeys)
      el.modal props
      @set 'jqueryElement', el
      @_super()

    willDestroyElement: ->
      el = Ember.$(@get 'element')
      el.off().removeData()