# Ember FormBuilder

Ember FormBuilder is a form builder implementation for [Ember.js](http://emberjs.com) and Handlebars. It's inspired by the Rails form builders, simple_form and formtastic.

## *!!! WARNING !!!*

README Driven Development: These features described below are _NOT_ yet implemented.

## Installation


Just download the latest version of the ember-formbuilder.js file and include it *after* ember.js.

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
Ember.FormBuilder.repoen(Bootstrap)
```
## Usage


Inside your Handlebars templates you can create forms simply using this DSL:

```html
{{#form_for "user" classes="form-horizontal"}}
  <legend>User Data:</legend>

  {{input "name" hint="Type your name"}}
  {{input "birthday" as="date"}}
  {{input "another_date" as="string" mask="##/##/####" component="datepicker"}}
  {{input "email" placeholder="mail@example.com"}}
  {{input "gender" as="select" collection=App.genders}}
  {{input "categories" as="checkboxes" collectionBinding="App.categoriesController"}}
  {{input "option" as="radio_buttons" collectionBinding="App.optionsController"}}

  {{#fields_for books}}
    {{input "title"}}
    {{input "author"}}
    {{remove_association "Remove Book" classes="btn btn-danger"}}
  {{/fields}}
  {{add_association "books" text="Add Book" classes="btn btn-success"}}

  {{submit "Save"}}
  {{cancel "Reset"}}
{{/form}}
```

This form sets properties inside the `user` object with the names passed to the `input` helper. 
If you don't have an object to bind the properties, well, you should. Just create an hypothetical object to bind over here, properties are created and defaulted to string if they don't exist.
Syntax is pretty straightforward and similar to SimpleForms one.
The add/remove association is inspired by the Cocoon gem.
### Events


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
### Client-Side Validations


You can set up validations within the object that your form is dealing with, here is an example that covers most of it:

```coffeescript
App.User = Ember.Object.extend
  validateUppon: 'fill' # could be either 'fill' or 'submit', defaults to 'submit'
  validate:
    name:
      presence: true
      length: [2, 25]
    email:
      presence: true
      email: true
    birthday:
      format: /\d{2}\/\d{2}\/\d{4}/
    books:
      length: [0, 10]
    gender:
      inclusion: 'male female'.w()
    categories:
      each:
        inclusion: App.categoriesController
```

### Labels, hints, error messages, and placeholders


You can redefine the label with the `label=` option, and so with other parameters:

```html
{{input "name" label="Su nombre"}}
```

But the most manageable and suggested way tho is to define your strings inside the `Ember.FormBuilder.STRINGS` dictionary:

```coffeescript
Ember.FormBuilder.STRINGS =
  defaults:
    required: '*'
    errorMessages:
      presence: 'should be present'
      format: 'should be valid'
  user:
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