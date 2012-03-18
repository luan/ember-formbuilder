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
          {{#formFor "object" classes="form-horizontal"}}
            {{input "name"}}
            {{submit "Save"}}
            {{cancel "Save"}}
          {{/formFor}}

          <span id="name">{{object.name}}</span>
        </section>
      '

      objectSubmit: ->
        @set 'submitFired', true

      objectCancel: ->
        @set 'cancelFired', true

    view.set 'object', object
    appendView()

  teardown: ->
    view.destroy() if view
    object.destroy() if object

test "basic formFor call for object", ->
  ok /<section>.*<form.*<\/section>.*/.test(view.$().html()), "form should be correctly set"

test "form classes is set", ->
  ok view.$('form').hasClass('form-horizontal')

test "submit and cancel looks like they should", ->
  submit = view.$('form .submit-button')
  cancel = view.$('form .cancel-button')

  ok submit.hasClass('btn btn-success'), 'submit classes'
  ok cancel.hasClass('btn btn-danger'), 'cancel classes'

  ok submit.get(0).tagName.toLowerCase() is 'button', 'submit tagName'
  ok cancel.get(0).tagName.toLowerCase() is 'a', 'cancel tagName'

test "submit fires event on the parent view", ->
  submit = view.$('form .submit-button')

  Ember.run ->
    Ember.View.views[submit.attr('id')].click()

  ok view.submitFired?

test "cancel fires event on the parent view", ->
  cancel = view.$('form .cancel-button')

  Ember.run ->
    Ember.View.views[cancel.attr('id')].click()

  ok view.cancelFired?

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

test "select tag", ->
  people = Ember.ArrayProxy.create([{id: 1, firstName: 'Yehuda'}, {id: 1, firstName: 'Yehuda'}])
  object = Ember.Object.create()

  view = Ember.View.create
    people: people
    object: object

    template:
      Ember.Handlebars.compile '
        <section>
          {{#formFor "object" classes="form-horizontal"}}
            {{input "person" as="select" collectionBinding="people" prompt="Please select"}}
          {{/formFor}}
        </section>
    '

  appendView()

  console.log view.$("form select")
  ok view.$("form select").length > 0, "should have select tag"
  equal(view.$("form select").val(), 'Please select', "By default, the prompt is selected in the DOM")
  equal(view.$("form select").find('option').length, 2, "Options were rendered")
