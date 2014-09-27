window.Canvas = Ember.Application.create(rootElement: '#ember-app')

Canvas.Router.map ->
  @resource('pages')
  @resource('page', path: '/page/:id')

# Routes
Canvas.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo 'pages'

Canvas.PagesRoute = Ember.Route.extend
  model: ->
    @store.find('page')

Canvas.PageRoute = Ember.Route.extend
  model: (params) ->
    @store.find('page', params.id)

# Controllers
Canvas.PagesController = Ember.ArrayController.extend
  pages: Ember.computed.alias('model')

Canvas.PageController = Ember.ObjectController.extend
  actions:
    createItem: (params) ->
      section = @store.getById('section', params.section_id)
      console.log section
      item = @store.createRecord('item', params)
      item.save().then((item) -> section.get('items').addObject(item))

# Models
Canvas.Page = DS.Model.extend
  name:            DS.attr('string')
  sections:        DS.hasMany('section')
  orderedSections: Ember.computed -> @get('sections').sortBy('seat')

Canvas.Section = DS.Model.extend
  ORDERED_SECTION_TAGS:
    'problem':                  {seat: 0, col: 'col-md-2'}
    'solution':                 {seat: 1, col: 'col-md-2'}
    'unique-value-proposition': {seat: 2, col: 'col-md-2'}
    'unfair-advantage':         {seat: 3, col: 'col-md-2'}
    'customer-segments':        {seat: 4, col: 'col-md-3'}
    'existing-alternatives':    {seat: 5, col: 'col-md-2'}
    'key-metrics':              {seat: 6, col: 'col-md-2'}
    'high-level-concept':       {seat: 7, col: 'col-md-2'}
    'channels':                 {seat: 8, col: 'col-md-2'}
    'early-adopter':            {seat: 9, col: 'col-md-3'}
    'cost-structure':           {seat: 10, col: 'col-md-6'}
    'revenue-streams':          {seat: 11, col: 'col-md-6'}

  name:     DS.attr('string')
  items:    DS.hasMany('item')
  tag:      Ember.computed -> @get('name').dasherize()
  tagInfo:  Ember.computed -> @ORDERED_SECTION_TAGS[@get('tag')]
  seat:     Ember.computed -> @get('tagInfo').seat
  colClass: Ember.computed -> @get('tagInfo').col

Canvas.Item = DS.Model.extend
  section_id: DS.attr()
  content:    DS.attr('string')

Canvas.PageSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    sections:
      embedded: 'always'

Canvas.SectionSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    items:
      embedded: 'always'

# Components
Canvas.PageSectionComponent = Ember.Component.extend
  isEditing: false
  createItem: "createItem"
  actions:
    cancel: ->
      @set('isEditing', false)
    edit: ->
      @set('isEditing', true)
    createItem: ->
      sectionId = @get('sectionId')
      content   = @.$('input.item-content').val()
      @sendAction('createItem', section_id: sectionId, content: content)
      @set('isEditing', false)
