Ember.FormBuilder.Cancel = Ember.View.extend
  classNameBindings: ['classes']
  template: Ember.Handlebars.compile '{{text}}'

  init: ->
    @_super()
    @set 'tagName', @tagName or @form.cancelTag
    @set 'cancelClass', @cancelClass or @form.cancelClass

    @set 'classes', "#{@cancelClass} cancel-button"

  click: (event) ->
    @form.parentView["#{@form.objectName}Cancel"](event)

