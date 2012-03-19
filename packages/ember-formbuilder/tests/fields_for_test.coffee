view = null
object = null

appendView = ->
  Ember.run -> view.appendTo('#qunit-fixture')

module "fieldsFor Helper"
  setup: ->
    objects = []
    object = Ember.Object.create
      writer: Ember.Object.create
        firstName: 'Wilbur'
        lastName: 'Smith'
      books: Ember.ArrayProxy.create
        content: [
          Ember.Object.create(title: 'Book #1')
          Ember.Object.create(title: 'Book #2')
        ]

    view = Ember.View.create
      template: Ember.Handlebars.compile '
        <section>
          {{#formFor "myObject"}}
            <div class="writer">
              {{input "writer.firstName"}}
              {{input "writer.lastName"}}
            </div>
            <div class="books">
              {{#fieldsFor "books"}}
                {{input "title"}}
                {{removeAssociation "books" text="Remove Book" classes="btn btn-danger"}}
              {{/fieldsFor}}
            </div>
            {{addAssociation "books" objectClass="Ember.Object" text="Add Book" classes="btn btn-success"}}
          {{/formFor}}
        </section>
      '
    view.set 'myObject', object
    appendView()

  teardown: ->
    view.destroy() if view
    object.destroy() if object

test "inputs", ->
  equal view.$('form div.books input').length, 2
  equal view.$('form div.writer input').length, 2
  equal view.$('form div.writer div.control-group').length, 2

test "bindings", ->
  equal view.$('form div.books input').first().val(), 'Book #1'
  equal view.$('form div.books input').last().val(), 'Book #2'

  Ember.run ->
    books = object.get('books')
    books.objectAt(0).set('title', 'Changed #1')
    books.pushObject Ember.Object.create(title: 'Book #3')

  equal view.$('form div.books input').length, 3
  equal view.$('form div.books input').first().val(), 'Changed #1'
  notEqual view.$('form div.books input').last().val(), 'Changed #1'

test "add/remove associations", ->
  link = view.$('form a').last()

  ok link.hasClass('btn-success')
  ok link.text() is 'Add Book'

  Ember.run ->
    Ember.View.views[link.attr('id')].click()

  equal view.$('form div.books input').length, 3

  link = view.$('form a.btn-danger').last()

  ok link.hasClass('btn-danger')
  equal link.text(), 'Remove Book'

  Ember.run ->
    Ember.View.views[link.attr('id')].click()

  equal view.$('form div.books input').length, 1

test "should accepted has one association", ->
  equal view.$('form div.writer input').first().val(), 'Wilbur'
  equal view.$('form div.writer input').last().val(), 'Smith'

  Ember.run ->
    writer = object.get('writer')
    writer.set('firstName', 'Changed #1')

  equal view.$('form div.writer input').length, 2
  equal view.$('form div.writer input').first().val(), 'Changed #1'
  notEqual view.$('form div.writer input').last().val(), 'Changed #1'

