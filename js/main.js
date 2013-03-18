
require.config({
  baseUrl: 'js/',
  paths: {
    'jquery': '//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min',
    'ember': 'lib/ember',
    'ember.bootstrap': 'lib/ember-bootstrap'
  },
  shim: {
    'ember': {
      deps: ['lib/handlebars', 'jquery'],
      exports: 'Ember'
    },
    'lib/bootstrap': {
      deps: ['jquery']
    },
    'templates': {
      deps: ['ember']
    }
  }
});

define(['ember', 'views/ModalView', 'lib/bootstrap', 'templates'], function(Ember, ModalView) {
  var Site;
  window.Site = Site = Ember.Application.create({
    title: 'Fischub',
    copyright: "© Fischub " + ((new Date()).getFullYear())
  });
  Site.ContactView = ModalView.extend();
  Site.ModalTrigger = Ember.View.extend({
    click: function() {
      var modal;
      modal = this.get('modal');
      if (Ember.isEmpty(modal)) {
        modal = ModalView.create();
        this.set('modal', modal);
        console.log('before append');
        modal.append();
        return console.log('after append');
      } else {
        return Ember.$(modal.get('element')).modal('toggle');
      }
    }
  });
  return Site.Router.map(function() {
    this.resource('about');
    return this.route('contact');
  });
});
