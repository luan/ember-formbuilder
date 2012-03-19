Ember.FormBuilder.AddAssociation = Ember.View.extend
  tagName: 'a'
  classNameBindings: ['classes']
  template: Ember.Handlebars.compile '{{text}}'

  click: ->
    content = @content
    klass = Ember.getPath(@objectClass)
    content.pushObject klass.create(form: @form)
