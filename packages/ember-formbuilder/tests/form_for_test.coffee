view = null
object = null

appendView = ->
  Ember.run -> view.appendTo('#qunit-fixture')

module "formFor Helper"
  setup: ->
    object = Ember.Object.create()
    genders = Ember.ArrayProxy.create
      content: [
        { value: 'male', label: 'Male' },
        { value: 'female', label: 'Female' }
      ]
    view = Ember.View.create
      object: object
      genders: genders
      template: Ember.Handlebars.compile '
        <section>
          {{#formFor "object" classes="form-horizontal"}}
            {{input "name"}}
            {{input "gender" as="select" collectionBinding="parentView.genders" prompt="Please select"}}
            {{input "categories" as="checkboxes" collectionBinding="parentView.genders"}}
            {{input "option" as="radioButtons" collectionBinding="parentView.genders"}}

            {{submit "Save"}}
            {{cancel "Cancel"}}
          {{/formFor}}

          <span id="name">{{object.name}}</span>
        </section>
      '

      objectSubmit: ->
        @set 'submitFired', true

      objectCancel: ->
        @set 'cancelFired', true

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

  equal submit.get(0).tagName.toLowerCase(), 'button', 'submit tagName'
  equal cancel.get(0).tagName.toLowerCase(), 'a', 'cancel tagName'

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
  equal view.$('form label').first().text().trim(), 'Name', "should have default label"
  equal view.$('form label').first().attr('for'), view.$('form input').attr('id'), "should be for the given input"

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
  ok view.$("form select").length > 0, "should have select tag"
  equal(view.$("form select").val(), 'Please select', "By default, the prompt is selected in the DOM")
  equal(view.$("form select").find('option').length, 3, "Options were rendered")

test "select tag with bindings", ->
  Ember.run ->
    view.genders.pushObject Ember.Object.create(label: 'Another', value: 'an')
  
  equal(view.$("form select").find('option').length, 4, "Options were rendered")

test "checkboxes with bindings", ->
  Ember.run ->
    box = view.$("form label.checkbox input[type='checkbox']").last()
    box.attr 'checked', true
    Ember.View.views[box.attr('id')].change()
    view.genders.pushObject Ember.Object.create(label: 'Another', value: 'an')

  equal(view.$("form label.checkbox input[type='checkbox']").length, 3, "checkboxes were rendered")

  Ember.run ->
    console.log view.object.categories
    #view.object.categories

test "radio buttons with bindings", ->
  Ember.run ->
    view.genders.pushObject Ember.Object.create(label: 'Another', value: 'an')
  
  equal(view.$("form label.radio input[type='radio']").length, 3, "radios were rendered")
