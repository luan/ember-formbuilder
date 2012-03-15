get = Ember.get
set = Ember.set
getPath = Ember.getPath

view = null
object = null

delay = (ms, func) -> setTimeout func, ms

appendView = (v) ->
  Ember.run -> v.appendTo('#qunit-fixture')

module "formFor Helper"
  setup: ->
    object = Ember.Object.create()
    window.TemplateTests = Ember.Namespace.create()

  teardown: ->
    view.destroy() if view
    object.destroy() if object
    window.TemplateTests = undefined

test "basic formFor call for object", ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '<section>{{formFor "object"}}</section>'
  view.set 'object', object

  Ember.run ->
    appendView(view)

  ok /<section>.*<form.*<\/section>.*/.test(view.$().html()), "form should be correctly set"

test "inputs formFor with bindings", ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '
      <section>
        {{#formFor "object"}}
          {{input "name"}}
        {{/formFor}}
      </section>
    '
  view.set 'object', object

  Ember.run ->
    appendView(view)

  ok /<section>.*<form.*<\/section>.*/.test(view.$().html()), "form should be correctly set"
  ok view.$('form input').length > 0, "should have inputs"

  Ember.run ->
    object.set('name', 'My Name')
  ok view.$('form input').val() == 'My Name', "bindings should be bound"
