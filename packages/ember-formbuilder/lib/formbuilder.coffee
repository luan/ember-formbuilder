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
  formClass: ''
  submitClass: 'btn btn-success'
  cancelClass: 'btn btn-danger'
  submitTag: 'button'
  cancelTag: 'a'

Ember.FormBuilder = Ember.Namespace.create
  mixins:
    'bootstrap': Bootstrap

  pushMixin: (mixin, mixinName) ->
    @mixins[mixinName] = mixin

  getMixin: (mixinName) ->
    @mixins[mixinName]

require "ember-formbuilder/formbuilder/views/form"
require "ember-formbuilder/formbuilder/views/input"
require "ember-formbuilder/formbuilder/views/submit"
require "ember-formbuilder/formbuilder/views/cancel"
require "ember-formbuilder/formbuilder/views/radio_button"
require "ember-formbuilder/formbuilder/views/checkbox"
require "ember-formbuilder/formbuilder/helpers/form_for"
require "ember-formbuilder/formbuilder/helpers/input"
require "ember-formbuilder/formbuilder/helpers/submit"
require "ember-formbuilder/formbuilder/helpers/cancel"
