Ember.FormBuilder.AddAssociation = Ember.View.extend
  tagName: 'a'
  classNameBindings: ['classes']
  template: Ember.Handlebars.compile '{{text}}'

  click: ->
    console.log('oi')
    content = @get('content')
    cls = Ember.getPath(@get 'objectClass')
    content.pushObject cls.create()
