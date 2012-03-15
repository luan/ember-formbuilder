get = Ember.get
set = Ember.set
getPath = Ember.getPath

view = null
object = null

delay = (ms, func) -> setTimeout func, ms

appendView = (v) ->
  Ember.run -> v.appendTo('#qunit-fixture')

module "formFor Helper"
  setup: ->
    object = Ember.Object.create
      books: Ember.ArrayProxy.create
        content: [
          Ember.Object.create(title: 'Book #1')
          Ember.Object.create(title: 'Book #2')
        ]

    view = Ember.View.create
      template: Ember.Handlebars.compile '
        <section>
          {{#formFor "object"}}
            {{#fieldsFor "books"}}
              {{input "title"}}
              {{removeAssociation "books" text="Remove Book" classes="btn btn-danger"}}
            {{/fieldsFor}}
            {{addAssociation "books" objectClass="Ember.Object" text="Add Book" classes="btn btn-success"}}
          {{/formFor}}
        </section>
      '
    view.set 'object', object

  teardown: ->
    view.destroy() if view
    object.destroy() if object

test "inputs fieldsFor", ->
  Ember.run ->
    appendView(view)

  ok view.$('form div input').length is 2, "should have 2 nested divs"

test "bindings", ->
  Ember.run ->
    appendView(view)

  ok view.$('form div input').first().val() is 'Book #1', "values bind to correct child"
  ok view.$('form div input').last().val() is 'Book #2', "values bind to correct child"

  Ember.run ->
    books = object.get('books')
    books.objectAt(0).set('title', 'Changed #1')
    books.pushObject Ember.Object.create(title: 'Book #3')

  ok view.$('form div input').length is 3, "should have 3 nested divs"
  ok view.$('form div input').first().val() is 'Changed #1', "values bind to correct child"
  ok view.$('form div input').last().val() isnt 'Changed #1', "values DOESNT bind to wrong child"

test "add associations", ->
  Ember.run ->
    appendView(view)

  link = view.$('form a').last()

  ok link.hasClass('btn-success'), "should have the class specified"
  ok link.text() is 'Add Book', "should have a link to add association"

  Ember.run ->
    Ember.View.views[link.attr('id')].click()

  ok view.$('form div input').length is 3, "should have 3 nested divs"

test "remove associations", ->
  Ember.run ->
    appendView(view)

  link = view.$('form a').first()

  ok link.hasClass('btn-danger'), "should have the class specified"
  ok link.text() is 'Remove Book', "should have a link to remove association"

  Ember.run ->
    Ember.View.views[link.attr('id')].click()

  ok view.$('form div input').length is 1, "should have 1 nested divs"

