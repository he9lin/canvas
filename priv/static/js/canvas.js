(function() {
  window.Canvas = Ember.Application.create({
    rootElement: '#ember-app'
  });

  Canvas.Router.map(function() {
    this.resource('pages');
    return this.resource('page', {
      path: '/page/:id'
    });
  });

  Canvas.IndexRoute = Ember.Route.extend({
    redirect: function() {
      return this.transitionTo('pages');
    }
  });

  Canvas.PagesRoute = Ember.Route.extend({
    model: function() {
      return this.store.find('page');
    }
  });

  Canvas.PageRoute = Ember.Route.extend({
    model: function(params) {
      return this.store.find('page', params.id);
    }
  });

  Canvas.PagesController = Ember.ArrayController.extend({
    pages: Ember.computed.alias('model')
  });

  Canvas.PageController = Ember.ObjectController.extend({
    actions: {
      createItem: function(params) {
        var item, section;
        section = this.store.getById('section', params.section_id);
        console.log(section);
        item = this.store.createRecord('item', params);
        return item.save().then(function(item) {
          return section.get('items').addObject(item);
        });
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
        col: 'col-md-2'
      },
      'unfair-advantage': {
        seat: 3,
        col: 'col-md-2'
      },
      'customer-segments': {
        seat: 4,
        col: 'col-md-3'
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
        col: 'col-md-2'
      },
      'early-adopter': {
        seat: 9,
        col: 'col-md-3'
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
    isEditing: false,
    createItem: "createItem",
    actions: {
      cancel: function() {
        return this.set('isEditing', false);
      },
      edit: function() {
        return this.set('isEditing', true);
      },
      createItem: function() {
        var content, sectionId;
        sectionId = this.get('sectionId');
        content = this.$('input.item-content').val();
        this.sendAction('createItem', {
          section_id: sectionId,
          content: content
        });
        return this.set('isEditing', false);
      }
    }
  });

}).call(this);
