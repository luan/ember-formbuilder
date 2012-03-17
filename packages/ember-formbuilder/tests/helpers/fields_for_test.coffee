view = null
object = null

appendView = ->
  Ember.run -> view.appendTo('#qunit-fixture')

module "fieldsFor Helper"
  setup: ->
    objects = []
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
    appendView()

  teardown: ->
    view.destroy() if view
    object.destroy() if object

test "inputs", ->
  equal view.$('form div input').length, 2, "should have 2 nested divs"

test "bindings", ->
  equal view.$('form div input').first().val(), 'Book #1', "values bind to correct child"
  equal view.$('form div input').last().val(), 'Book #2', "values bind to correct child"

  Ember.run ->
    books = object.get('books')
    books.objectAt(0).set('title', 'Changed #1')
    books.pushObject Ember.Object.create(title: 'Book #3')

  equal view.$('form div input').length, 3, "should have 3 nested divs"
  equal view.$('form div input').first().val(), 'Changed #1', "values bind to correct child"
  notEqual view.$('form div input').last().val(), 'Changed #1', "values DOESNT bind to wrong child"

test "add associations", ->
  link = view.$('form a').last()

  ok link.hasClass('btn-success'), "should have the class specified"
  ok link.text() is 'Add Book', "should have a link to add association"

  Ember.run ->
    Ember.View.views[link.attr('id')].click()

  equal view.$('form div input').length, 3, "should have 3 nested divs"

test "remove associations", ->
  link = view.$('form a').first()

  ok link.hasClass('btn-danger'), "should have the class specified"
  equal link.text(), 'Remove Book', "should have a link to remove association"

  Ember.run ->
    Ember.View.views[link.attr('id')].click()

  equal view.$('form div input').length, 1, "should have 1 nested divs"

