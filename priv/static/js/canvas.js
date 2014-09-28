(function() {
  window.Canvas = Ember.Application.create({
    rootElement: '#ember-app'
  });

  Canvas.Router.map(function() {
    this.resource('pages', function() {
      return this.route('new');
    });
    return this.resource('page', {
      path: '/page/:id'
    }, function() {
      return this.route('settings');
    });
  });

  Canvas.IndexRoute = Ember.Route.extend({
    redirect: function() {
      return this.transitionTo('pages');
    }
  });

  Canvas.PagesIndexRoute = Ember.Route.extend({
    model: function() {
      return this.store.find('page');
    }
  });

  Canvas.PageRoute = Ember.Route.extend({
    model: function(params) {
      return this.store.find('page', params.id);
    }
  });

  Canvas.PagesIndexController = Ember.ArrayController.extend({
    pages: Ember.computed.alias('model')
  });

  Canvas.PagesNewController = Ember.ObjectController.extend({
    actions: {
      submitPageForm: function(params) {
        var page;
        page = this.store.createRecord('page', params);
        page.save();
        return this.transitionTo("pages.index");
      }
    }
  });

  Canvas.PageSettingsController = Ember.ObjectController.extend({
    actions: {
      submitPageForm: function(params) {
        var page;
        page = this.get('model');
        page.set('name', params.name).save();
        return this.transitionTo("page.index", page);
      },
      destroyPage: function() {
        this.get('model').destroyRecord();
        return this.transitionTo("pages.index");
      }
    }
  });

  Canvas.PageIndexController = Ember.ObjectController.extend({
    actions: {
      createItem: function(params) {
        var item, section;
        section = this.store.getById('section', params.section_id);
        item = this.store.createRecord('item', params);
        return item.save().then(function(item) {
          return section.get('items').addObject(item);
        });
      },
      destroyItem: function(itemId) {
        var item;
        item = this.store.getById('item', itemId);
        return item.destroyRecord();
      }
    }
  });

  Canvas.Page = DS.Model.extend({
    name: DS.attr('string'),
    sections: DS.hasMany('section'),
    orderedSections: Ember.computed(function() {
      return this.get('sections').sortBy('seat');
    })
  });

  Canvas.Section = DS.Model.extend({
    ORDERED_SECTION_TAGS: {
      'problem': {
        seat: 0,
        col: 'col-md-2'
      },
      'solution': {
        seat: 1,
        col: 'col-md-2'
      },
      'unique-value-proposition': {
        seat: 2,
        col: 'col-md-3'
      },
      'unfair-advantage': {
        seat: 3,
        col: 'col-md-2'
      },
      'customer-segments': {
        seat: 4,
        col: 'col-md-2'
      },
      'existing-alternatives': {
        seat: 5,
        col: 'col-md-2'
      },
      'key-metrics': {
        seat: 6,
        col: 'col-md-2'
      },
      'high-level-concept': {
        seat: 7,
        col: 'col-md-2'
      },
      'channels': {
        seat: 8,
        col: 'col-md-3'
      },
      'early-adopter': {
        seat: 9,
        col: 'col-md-2'
      },
      'cost-structure': {
        seat: 10,
        col: 'col-md-6'
      },
      'revenue-streams': {
        seat: 11,
        col: 'col-md-6'
      }
    },
    name: DS.attr('string'),
    items: DS.hasMany('item'),
    tag: Ember.computed(function() {
      return this.get('name').dasherize();
    }),
    tagInfo: Ember.computed(function() {
      return this.ORDERED_SECTION_TAGS[this.get('tag')];
    }),
    seat: Ember.computed(function() {
      return this.get('tagInfo').seat;
    }),
    colClass: Ember.computed(function() {
      return this.get('tagInfo').col;
    })
  });

  Canvas.Item = DS.Model.extend({
    section_id: DS.attr(),
    content: DS.attr('string')
  });

  Canvas.PageSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
    attrs: {
      sections: {
        embedded: 'always'
      }
    }
  });

  Canvas.SectionSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
    attrs: {
      items: {
        embedded: 'always'
      }
    }
  });

  Canvas.PageSectionComponent = Ember.Component.extend({
    createItem: "createItem",
    destroyItem: "destroyItem",
    actions: {
      destroyItem: function(itemId) {
        return this.sendAction('destroyItem', itemId);
      },
      createItem: function() {
        var content, sectionId;
        sectionId = this.get('sectionId');
        content = this.$('input.item-content').val();
        this.sendAction('createItem', {
          section_id: sectionId,
          content: content
        });
        return this.$('input.item-content').val('');
      }
    }
  });

  Canvas.PageFormComponent = Ember.Component.extend({
    submitPageForm: "submitPageForm",
    actions: {
      submit: function() {
        var name;
        name = this.$('input[name=name]').val();
        return this.sendAction('submitPageForm', {
          name: name
        });
      }
    }
  });

  Canvas.SectionItemComponent = Ember.Component.extend({
    destroyItem: "destroyItem",
    actions: {
      destroy: function() {
        var itemId;
        itemId = this.get('itemId');
        return this.sendAction('destroyItem', itemId);
      }
    }
  });

}).call(this);
