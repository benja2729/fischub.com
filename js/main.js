require.config({
  baseUrl: 'js/',
  paths: {
    'jquery': '//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min',
    'ember': 'lib/ember'
  },
  shim: {
    'ember': {
      deps: ['lib/handlebars', 'jquery'],
      exports: 'Ember'
    },
    'templates': {
      deps: ['ember', 'lib/handlebars']
    }
  }
});

require(['ember', 'mixins/JQ/Modal', 'templates'], function(Ember, JQModal) {
  var Site;

  window.Site = Site = Ember.Application.create({
    title: 'Fischub',
    copyright: "© Fischub " + ((new Date()).getFullYear())
  });
  Site.ContactView = Ember.View.extend(JQModal, {
    templateName: 'modal',
    close: function() {
      return this.get('jqElement').modal('hide');
    },
    show: function() {
      return console.log('showing');
    },
    hidden: function() {
      return this.destroy();
    },
    header: 'Header Text',
    body: 'Body Text'
  });
  Site.ModalTrigger = Ember.View.extend({
    init: function() {
      var modal;

      this._super();
      modal = Ember.View.createWithMixins(JQModal, {
        templateName: 'modal',
        jqOptions: {
          show: false
        },
        animate: true,
        show: function() {
          return console.log('ModalTrigger->show has been fired');
        },
        shown: function() {
          return console.log('ModalTrigger->shown go boom!');
        },
        hide: function() {
          return console.log('hide');
        },
        hidden: function() {
          return console.log('hidden');
        },
        header: 'Header Text',
        body: 'Body Text'
      });
      this.set('modal', modal);
      window.modal = modal;
      return modal.append();
    },
    click: function() {
      return this.get('modal').get('jqElement').modal('toggle');
    }
  });
  return Site.Router.map(function() {
    this.resource('about');
    return this.route('contact');
  });
});
