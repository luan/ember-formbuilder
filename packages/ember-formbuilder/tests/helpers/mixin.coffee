view = null
object = null

Custom = Ember.Mixin.create
  wrapperTag: 'section'
  wrapperClass: 'custom-group'
  inputWrapperTag: 'span'
  inputWrapperClass: 'custom-controls'
  labelClass: 'custom-label'
  helpTag: 'span'
  helpClass: 'help'
  errorTag: 'p'
  errorClass: 'error'
  formClass: 'form'
  submitClass: 'submit'
  cancelClass: 'cancel'

appendView = ->
  Ember.run -> view.appendTo('#qunit-fixture')

module "formFor Helper with mixins"
  setup: ->
    object = Ember.Object.create()
    Ember.FormBuilder.pushMixin(Custom, 'custom')
    view = Ember.View.create
      template: Ember.Handlebars.compile '
        <section>
          {{#formFor "object" mixin="custom"}}
            {{input "name" hint="my hint" error="my error"}}
          {{/formFor}}
          
          <span id="name">{{object.name}}</span>
        </section>
      '
    view.set 'object', object
    appendView()

  teardown: ->
    view.destroy() if view
    object.destroy() if object

test "mixin properties", ->
  console.log view.$('form')
  ok view.$('form').hasClass('form'), "form class"
  ok view.$('form section.custom-group').length > 0, "wrapper tag"
  ok view.$('form section.custom-group span.custom-controls').length > 0, "input wrapper tag"
  ok view.$('form section.custom-group label.custom-label').length > 0, "has a label"
  ok view.$('form section.custom-group span.help').text().trim() is 'my hint', "hint with class"
  ok view.$('form section.custom-group p.error').text().trim() is 'my error', "error with class"
