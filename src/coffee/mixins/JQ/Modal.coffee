
define [
  'ember', './Core'

  'lib/bootstrap-modal', 'lib/bootstrap-transition'
], (Ember, JQCore) ->

  Modal = Ember.Mixin.create JQCore,
    tagName: 'article'
    classNames: ['modal']
    classNameBindings: ['animate:fade:']
    animate: true

    _jqDefaults: Ember.$.fn.modal.defaults
    _jqEvents: ['show', 'shown', 'hide', 'hidden']

    willInsertElement: ->
      @_super()
      el = @get 'jqElement'
      el.modal(@get 'jqOptions')

    willDestroyElement: ->
      @_super()
      el = @get 'jqElement'
      el.removeData 'modal'

  Ember.JQ.Modal = Modal