define(['ember', './Core', 'lib/bootstrap-modal', 'lib/bootstrap-transition'], function(Ember, JQCore) {
  var Modal;

  Modal = Ember.Mixin.create(JQCore, {
    tagName: 'article',
    classNames: ['modal'],
    classNameBindings: ['animate:fade:'],
    animate: true,
    _jqDefaults: Ember.$.fn.modal.defaults,
    _jqEvents: ['show', 'shown', 'hide', 'hidden'],
    willInsertElement: function() {
      var el;

      this._super();
      el = this.get('jqElement');
      return el.modal(this.get('jqOptions'));
    },
    willDestroyElement: function() {
      var el;

      this._super();
      el = this.get('jqElement');
      return el.removeData('modal');
    }
  });
  return Ember.JQ.Modal = Modal;
});
