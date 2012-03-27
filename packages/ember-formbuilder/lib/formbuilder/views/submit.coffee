Ember.FormBuilder.Submit = Ember.View.extend
  classNameBindings: ['classes']
  template: Ember.Handlebars.compile '{{{text}}}'

  init: ->
    @_super()
    @set 'tagName', @tagName or @form.submitTag
    @set 'submitClass', @submitClass or @form.submitClass

    @set 'classes', "#{@submitClass} submit-button"

  click: (event) ->
    @form.parentView["#{@form.objectName}Submit"](event)

