# Ember FormBuilder

**This library is obsolete, there is a more updated library that achieves the same goals as this was supposed to.*(
**[ember-easyform](https://github.com/dockyard/ember-easyForm) by @dockyard.**

## OLD README:

Ember FormBuilder is a form builder implementation for [Ember.js](http://emberjs.com) and Handlebars. It's inspired by the Rails form builders, simple_form and formtastic.

I wrote a blog post about it: http://blog.luansantos.com/2012/03/19/introducing-ember-formbuilder/

## Installation

Just download the latest version of the ember-formbuilder.js file and include it **after** ember.js.

## Configuration

Ember FormBuilder comes with (for now) one configuration built in. Configurations are made using Embers Mixins. The default built-in configuration generates forms according to [Twitter Bootstrap 2.0](http://twitter.github.com/bootstrap/).
In order to create your own configuration just create an Ember Mixin and then include it into the FormBuilders core:

```coffeescript
Bootstrap = Ember.Mixin.create
  wrapperTag: 'div'
  wrapperClass: 'control-group'
  inputWrapperTag: 'div'
  inputWrapperClass: 'controls'
  labelClass: 'control-label'
  helpTag: 'p'
  helpClass: 'help-block'
  errorTag: 'span'
  errorClass: 'help-inline'
  formClass: 'form-vertical'
  submitClass: 'btn btn-success'
  cancelClass: 'btn btn-danger'
Ember.FormBuilder.pushMixin(Bootstrap, "bootstrap")
```

## Usage

Inside your Handlebars templates you can create forms simply using this DSL:

```html
{{#formFor "user" mixin="bootstrap" classes="form-horizontal"}}
  <legend>User Data:</legend>

  {{input "name" hint="Type your name"}}
  {{input "email" placeholder="mail@example.com"}}
  {{input "gender" as="select" collectionBinding="App.genders"}}

  {{submit "Save"}}
  {{cancel "Reset"}}
{{/form}}
```

This form sets properties inside the `user` object with the names passed to the `input` helper.
If you don't have an object to bind the properties, well, you should. Just create an hypothetical object to bind over here, properties are created and defaulted to string if they don't exist.
Syntax is pretty straightforward and similar to SimpleForms.
The add/remove association is inspired by the Cocoon gem.

## Events

FormBuilder automatically fires events in the view, they are:
* <modelName>Submit
* <modelName>Cancel

In order to get called when property changes just set up observers on them.

For example on the former snippet:

```coffeescript
App.EditUserView = Ember.View.extend
  # . . .
  userSubmit: (user) ->
    # you get passed the object for convenience
    # do whatever you want

  userCancel: (oldUser, user) ->
    # oldUser = former state, the state when the form was loaded
    # user = current state, the current user counting the editings on the form
    # do whatever you want
    # return false to disable default behavior (which is resetting the properties)
```

## Labels, hints and placeholders

You can redefine the label with the `label=` option, and so with other parameters:

```html
{{input "name" label="Su nombre"}}
```

But the most manageable and suggested way tho is to define your strings inside the `Ember.FormBuilder.STRINGS` dictionary:

```coffeescript
Ember.FormBuilder.STRINGS =
  defaults:
    submit: 'Submit'
    cancel: 'Reset'
    labels:
      name: 'Name'
  user:
    submit: 'Save'
    cancel: 'Cancel'
    labels:
      name: 'Name:'
      email: 'Email:'
    hints:
      name: 'Type your name.'
      email: 'Type your email.'
    placeholders:
      name: 'John Smith'
      email: 'john@example.com'
```

## Planned features

```html
  {{input "birthday" as="date"}}
  {{input "another_date" as="string" mask="##/##/####" component="datepicker"}}
  {{input "categories" as="checkboxes" collectionBinding="App.categoriesController"}}
  {{input "option" as="radio_buttons" collectionBinding="App.optionsController"}}

  <div class="books">
    {{#fieldsFor "book"}}
      <div class="books">
        {{input "title"}}
        {{input "author"}}
        {{removeAssociation "books" text="Remove Book" classes="btn btn-danger"}}
      </div>
    {{/fieldsFor}}
  </div>
  {{addAssociation "books" text="Add Book" objectClass="App.Models.Book" classes="btn btn-success"}}
```
