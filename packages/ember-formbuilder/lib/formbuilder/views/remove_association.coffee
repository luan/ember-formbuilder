Ember.FormBuilder.RemoveAssociation = Ember.View.extend
  tagName: ''
  classNameBindings: ['classes']
  template: Ember.Handlebars.compile '<a href="#" {{action "click"}}>{{text}}</a>'

  click: ->
    collection = @get('collection')
    content = @get('content')
    collection.removeObject(content)
