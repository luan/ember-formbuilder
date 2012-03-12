Ember.FormBuilder = Ember.Namespace.create
  wrapperTag: 'div'
  wrapperClass: 'control-group'
  inputWrapperTag: 'div'
  inputWrapperClass: 'controls'
  labelClass: 'control-label'
  helpTag: 'p'
  helpClass: 'help-block'
  errorTag: 'span'
  errorClass: 'help-inline'

require "ember-formbuilder/formbuilder/views/form"
require "ember-formbuilder/formbuilder/views/input"
require "ember-formbuilder/formbuilder/views/_info"
require "ember-formbuilder/formbuilder/views/help"
require "ember-formbuilder/formbuilder/views/error"
