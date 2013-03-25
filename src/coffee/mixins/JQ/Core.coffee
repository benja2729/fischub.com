
define ['ember', 'jquery'], (Ember, $) ->

  getKeys = (obj) -> (key for own key of obj)

  Core = Ember.Mixin.create
    init: ->
      @_super()
      opts = @get 'jqOptions'
      if $.isEmptyObject opts then @set 'jqOptions', opts

    _jqDefaults: {}
    _jqOptions: {}
    _jqEvents: []
    concatenatedProperties: ['_jqEvents']

    jqElement: (() -> $(@get 'element')).property 'element'

    jqOptions: ((key, value) ->
      opts = @get '_jqOptions'

      if value isnt undefined
        defaults = @get '_jqDefaults'
        opts = Ember.Object.create($.extend {}, defaults, opts, value)
        @set '_jqOptions', opts

      opts
    ).property '_jqOptions'

    jqEvents: (() ->
      events = @getProperties @get('_jqEvents')
      ret = {}
      for own key, value of events
        if value isnt undefined then ret[key] = value
      ret
    ).property '_jqEvents'

    willInsertElement: ->
      @_super()

      # Make jQuery options available as Ember properties
      # options = @_attachOptions()

      # Make sure that jQuery UI events trigger methods on this view
      @_attachEvents()

    # When Ember tears down the view's DOM element, it will call this method
    willDestroyElement: ->
      @_super()
      el = @get 'jqElement'

      # Remove jQuery bound events
      events = @get '_jqEvents'
      el.off(events.join ' ')

    # Each jQuery UI widget has a series of options that can be configured.
    # For instance, to disable a button, you call `button.options('disabled', true)`
    # To make this compatible with Ember bindings, any time the Ember
    # property for a given jQuery UI option changes, we update the jQuery widget
    _attachOptions: () ->
      jqOptions = @get 'jqOptions'
      options = {}

      # The view can specify a list of jQuery UI options that should be treated
      # as Ember properties
      for own key, value of jqOptions
        options[key] = value

        # Set up an observer on the Ember property. When it changes, call
        # jQuery UI's `setOption` method to reflect the property onto the
        # jQuery UI widget
        observer = -> @get('ui')._setOption key, value

        @addObserver key, observer

        # Insert the observer in the Hash so we can remove it later.
        @_observers = @_observers or {}
        @_observers[key] = observer

      options

    _attachEvents: ->
      events = @get '_jqEvents'
      el = @get 'jqElement'

      for event in events then el.on event, (event) => @trigger event.type

  Ember.JQ = Ember.JQ or {}
  Ember.JQ.Core = Core
