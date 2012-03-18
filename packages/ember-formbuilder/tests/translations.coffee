view = null
object = null

appendView = ->
  Ember.run -> view.appendTo('#qunit-fixture')

module "translations"
  setup: ->
    object = Ember.Object.create()
    view = Ember.View.create
      template: Ember.Handlebars.compile '
        <section>
          {{#formFor "object" classes="form-horizontal"}}
            {{input "name"}}

            {{submit}}
            {{cancel}}
          {{/formFor}}
          
          <span id="name">{{object.name}}</span>
        </section>
      '
    view.set 'object', object

  teardown: ->
    Ember.FormBuilder.STRINGS = {}
    view.destroy() if view
    object.destroy() if object

test "translates attributes correctly with custom values", ->
  Ember.FormBuilder.STRINGS =
    defaults:
      labels:
        name: 'Your name'
      hints:
        name: 'Full name'
      placeholders:
        name: 'Type your full name'
      submit: 'Submit'
      cancel: 'Cancel'
    object:
      labels:
        name: 'Type your name:'
      hints:
        name: 'The name of yours'
      placeholders:
        name: 'Naaaame'
      submit: 'Send'
      cancel: 'Reset'

  appendView()

  equal view.$('form label').text().trim(), 'Type your name:'
  equal view.$('form .help-block').text().trim(), 'The name of yours'
  equal view.$('form input').attr('placeholder').trim(), 'Naaaame'
  equal view.$('form .submit-button').text().trim(), 'Send'
  equal view.$('form .cancel-button').text().trim(), 'Reset'

test "translates attributes correctly with default values", ->
  Ember.FormBuilder.STRINGS =
    defaults:
      labels:
        name: 'Your name'
      hints:
        name: 'Full name'
      placeholders:
        name: 'Type your full name'
      submit: 'Submit'

  appendView()

  equal view.$('form label').text().trim(), 'Your name'
  equal view.$('form .help-block').text().trim(), 'Full name'
  equal view.$('form input').attr('placeholder').trim(), 'Type your full name'
  equal view.$('form .submit-button').text().trim(), 'Submit'
  equal view.$('form .cancel-button').text().trim(), 'Cancel'
