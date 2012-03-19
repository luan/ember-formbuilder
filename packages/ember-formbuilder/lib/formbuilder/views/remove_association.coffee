Ember.FormBuilder.RemoveAssociation = Ember.View.extend
  tagName: 'a'
  classNameBindings: ['classes']
  template: Ember.Handlebars.compile '{{text}}'

  click: ->
    console.log 'coll:', @
    window.v = this
    collection = @collection
    content = @content
    collection.removeObject(content)
