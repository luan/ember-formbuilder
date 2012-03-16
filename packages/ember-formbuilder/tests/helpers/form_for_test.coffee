view = null
object = null

appendView = ->
  Ember.run -> view.appendTo('#qunit-fixture')

module "formFor Helper"
  setup: ->
    object = Ember.Object.create()
    view = Ember.View.create
      template: Ember.Handlebars.compile '
        <section>
          {{#formFor "object"}}
            {{input "name" label="cebolas"}}
          {{/formFor}}
          
          <span id="name">{{object.name}}</span>
        </section>
      '
    view.set 'object', object
    appendView()

  teardown: ->
    view.destroy() if view
    object.destroy() if object

test "basic formFor call for object", ->
  ok /<section>.*<form.*<\/section>.*/.test(view.$().html()), "form should be correctly set"
  
test "input label", ->
  ok view.$('form label').text().trim() is 'Name', "should have default label"
  ok view.$('form label').attr('for') is view.$('form input').attr('id'), "should be for the given input"

test "inputs with bindings", ->
  ok /<section>.*<form.*<\/section>.*/.test(view.$().html()), "form should be correctly set"
  ok view.$('form input').length > 0, "should have inputs"

  Ember.run ->
    object.set('name', 'My Name')
    
  ok view.$('form input').val() is 'My Name', "bindings should be bound"
  
  Ember.run ->
    ok view.$('form input').val('Changed Again')
    Ember.View.views[view.$('form input').attr('id')].change()
    
  ok object.get('name') is 'Changed Again', "bindings should be bound both sides"
  ok $('#name').text() is 'Changed Again', "binds to all instances"
