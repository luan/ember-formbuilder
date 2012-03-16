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

Ember.FormBuilder = Ember.Namespace.create
  mixins:
    'bootstrap': Bootstrap

  pushMixin: (mixin, mixinName) ->
    @mixins[mixinName] = mixin

  getMixin: (mixinName) ->
    @mixins[mixinName]

require "ember-formbuilder/formbuilder/views/form"
require "ember-formbuilder/formbuilder/views/input"
require "ember-formbuilder/formbuilder/views/add_association"
require "ember-formbuilder/formbuilder/views/remove_association"
require "ember-formbuilder/formbuilder/views/nested_fields"
require "ember-formbuilder/formbuilder/helpers/form_for"
require "ember-formbuilder/formbuilder/helpers/fields_for"
require "ember-formbuilder/formbuilder/helpers/input"
require "ember-formbuilder/formbuilder/helpers/add_association"
require "ember-formbuilder/formbuilder/helpers/remove_association"
