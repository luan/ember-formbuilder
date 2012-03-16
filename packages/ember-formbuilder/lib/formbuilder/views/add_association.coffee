Ember.FormBuilder.AddAssociation = Ember.View.extend
  tagName: 'a'
  classNameBindings: ['classes']
  template: Ember.Handlebars.compile '{{text}}'

  click: ->
    content = @content
    cls = Ember.getPath(@objectClass)
    content.pushObject cls.create()
