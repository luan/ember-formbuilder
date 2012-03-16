Ember.FormBuilder.AddAssociation = Ember.View.extend
  tagName: ''
  classNameBindings: ['classes']
  template: Ember.Handlebars.compile '<a href="#" {{action "click"}}>{{text}}</a>'

  click: ->
    content = @get('content')
    cls = Ember.getPath(@get 'objectClass')
    content.pushObject cls.create()