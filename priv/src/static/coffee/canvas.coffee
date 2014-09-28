window.Canvas = Ember.Application.create(rootElement: '#ember-app')

Canvas.Router.map ->
  @resource 'pages', ->
    @route('new')
  @resource('page', path: '/page/:id')

# Routes
Canvas.IndexRoute = Ember.Route.extend
  redirect: -> @transitionTo 'pages'

Canvas.PagesIndexRoute = Ember.Route.extend
  model: ->
    @store.find('page')

Canvas.PageRoute = Ember.Route.extend
  model: (params) ->
    @store.find('page', params.id)

# Controllers
Canvas.PagesIndexController = Ember.ArrayController.extend
  pages: Ember.computed.alias('model')

Canvas.PagesNewController = Ember.ObjectController.extend
  actions:
    createPage: (params) ->
      page = @store.createRecord('page', params)
      page.save()
      @transitionTo("pages.index")

Canvas.PageController = Ember.ObjectController.extend
  actions:
    createItem: (params) ->
      section = @store.getById('section', params.section_id)
      item    = @store.createRecord('item', params)
      item.save().then((item) -> section.get('items').addObject(item))
    destroyItem: (itemId) ->
      item = @store.getById('item', itemId)
      item.destroyRecord()

# Models
Canvas.Page = DS.Model.extend
  name:            DS.attr('string')
  sections:        DS.hasMany('section')
  orderedSections: Ember.computed -> @get('sections').sortBy('seat')

Canvas.Section = DS.Model.extend
  ORDERED_SECTION_TAGS:
    'problem':                  {seat: 0, col: 'col-md-2'}
    'solution':                 {seat: 1, col: 'col-md-2'}
    'unique-value-proposition': {seat: 2, col: 'col-md-3'}
    'unfair-advantage':         {seat: 3, col: 'col-md-2'}
    'customer-segments':        {seat: 4, col: 'col-md-2'}
    'existing-alternatives':    {seat: 5, col: 'col-md-2'}
    'key-metrics':              {seat: 6, col: 'col-md-2'}
    'high-level-concept':       {seat: 7, col: 'col-md-2'}
    'channels':                 {seat: 8, col: 'col-md-3'}
    'early-adopter':            {seat: 9, col: 'col-md-2'}
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
  createItem: "createItem"
  destroyItem: "destroyItem"
  actions:
    destroyItem: (itemId) ->
      @sendAction('destroyItem', itemId)
    createItem: ->
      sectionId = @get('sectionId')
      content   = @.$('input.item-content').val()
      @sendAction('createItem', section_id: sectionId, content: content)
      @.$('input.item-content').val('')

Canvas.PageFormComponent = Ember.Component.extend
  createPage: "createPage"
  actions:
    submit: ->
      name = @.$('input[name=name]').val()
      @sendAction('createPage', name: name)

Canvas.SectionItemComponent = Ember.Component.extend
  destroyItem: "destroyItem"
  actions:
    destroy: ->
      itemId = @get('itemId')
      @sendAction('destroyItem', itemId)
