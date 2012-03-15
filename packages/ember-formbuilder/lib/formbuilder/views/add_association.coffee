Ember.FormBuilder.AddAssociation = Ember.View.extend
  tagName: 'a'
  classNameBindings: ['classes']
  template: Ember.Handlebars.compile '{{text}}'

  click: ->
    content = @get('content')
    cls = Ember.getPath(@get 'objectClass')
    content.pushObject cls.create()
