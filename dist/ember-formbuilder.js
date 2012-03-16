
(function(exports) {

  Ember.FormBuilder = Ember.Namespace.create({
    wrapperTag: 'div',
    wrapperClass: 'control-group',
    inputWrapperTag: 'div',
    inputWrapperClass: 'controls',
    labelClass: 'control-label',
    helpTag: 'p',
    helpClass: 'help-block',
    errorTag: 'span',
    errorClass: 'help-inline'
  });



























})({});


(function(exports) {

  Ember.Handlebars.registerHelper("addAssociation", function(property, options) {
    ember_assert("The addAssociation helper only takes a single argument", arguments.length <= 2);
    options.hash.contentBinding = "bindingContext.object." + property;
    options.hash.preserveContext = false;
    return Ember.Handlebars.helpers.view.call(this, 'Ember.FormBuilder.AddAssociation', options);
  });

})({});


(function(exports) {

  Ember.Handlebars.registerHelper("fieldsFor", function(property, options) {
    ember_assert("The fieldsFor helper only takes a single argument", arguments.length <= 2);
    options.hash.contentBinding = "bindingContext.object." + property;
    options.hash.preserveContext = false;
    return Ember.Handlebars.helpers.collection.call(this, 'Ember.FormBuilder.NestedFields', options);
  });

})({});


(function(exports) {

  Ember.Handlebars.registerHelper("formFor", function(object, options) {
    ember_assert("The formFor helper only takes a single argument", arguments.length <= 2);
    options.hash.contentBinding = object;
    options.hash.preserveContext = true;
    return Ember.Handlebars.helpers.view.call(this, 'Ember.FormBuilder.Form', options);
  });

})({});


(function(exports) {

  Ember.Handlebars.registerHelper("input", function(property, options) {
    var words;
    ember_assert("The input helper only takes a single argument", arguments.length <= 2);
    if (!options.hash.label) {
      words = Ember.String.underscore(property).split('_');
      words = words.map(function(word) {
        return word.charAt(0).toUpperCase() + word.substring(1);
      });
      options.hash.label = words.join(' ');
    }
    options.hash.valueBinding = "content." + property;
    options.hash.preserveContext = true;
    return Ember.Handlebars.helpers.view.call(this, 'Ember.FormBuilder.Input', options);
  });

})({});


(function(exports) {

  Ember.Handlebars.registerHelper("removeAssociation", function(property, options) {
    ember_assert("The removeAssociation helper only takes a single argument", arguments.length <= 2);
    options.hash.contentBinding = "content";
    options.hash.collectionBinding = "bindingContext.content." + property;
    options.hash.preserveContext = true;
    return Ember.Handlebars.helpers.view.call(this, 'Ember.FormBuilder.RemoveAssociation', options);
  });

})({});


(function(exports) {

  Ember.FormBuilder.Info = Ember.View.extend({
    classNameBindings: ['classes'],
    template: Ember.Handlebars.compile('{{text}}')
  });

})({});


(function(exports) {

  Ember.FormBuilder.AddAssociation = Ember.View.extend({
    tagName: '',
    classNameBindings: ['classes'],
    template: Ember.Handlebars.compile('<a href="#" {{action "click"}}>{{text}}</a>'),
    click: function() {
      var cls, content;
      content = this.get('content');
      cls = Ember.getPath(this.get('objectClass'));
      return content.pushObject(cls.create());
    }
  });

})({});


(function(exports) {

  Ember.FormBuilder.Error = Ember.FormBuilder.Info.extend({
    init: function() {
      this._super();
      this.set('classes', this.get('classes') || Ember.FormBuilder.errorClass);
      return this.set('tagName', this.get('tagName') || Ember.FormBuilder.errorTag);
    }
  });

})({});


(function(exports) {

  Ember.FormBuilder.Form = Ember.View.extend({
    tagName: 'form',
    classNameBindings: ['classes']
  });

})({});


(function(exports) {

  Ember.FormBuilder.Help = Ember.FormBuilder.Info.extend({
    init: function() {
      this._super();
      this.set('classes', this.get('classes') || Ember.FormBuilder.helpClass);
      return this.set('tagName', this.get('tagName') || Ember.FormBuilder.helpTag);
    }
  });

})({});


(function(exports) {

  Ember.FormBuilder.Input = Ember.View.extend({
    tagName: Ember.FormBuilder.wrapperTag,
    classNameBindings: ['wrapperClass', 'infoClass'],
    inputClass: '',
    label: '',
    init: function() {
      this._super();
      this.set('inputView', this.get('inputView') || 'Ember.TextField');
      this.set('inputWrapperTag', this.get('inputWrapperTag') || Ember.FormBuilder.inputWrapperTag);
      this.set('inputWrapperClass', this.get('inputWrapperClass') || Ember.FormBuilder.inputWrapperClass);
      this.set('wrapperClass', this.get('wrapperClass') || Ember.FormBuilder.wrapperClass);
      if (this.get('showLabel') === void 0) this.set('showLabel', true);
      this.set('infoClass', this.get('infoClass') || '');
      if (Ember.empty(this.get('value'))) this.set('value', '');
      return this.set('template', Ember.Handlebars.compile('\
      {{#if showLabel}}\
        <label class="string required control-label" for="' + Ember.guidFor(this) + 'input">\
          {{label}}\
        </label>\
      {{/if}}\
      {{#view Ember.View tagName=inputWrapperTag class=inputWrapperClass contentBinding="this"}}\
        {{view ' + this.inputView + ' id="' + Ember.guidFor(this) + 'input" class=content.inputClass valueBinding="content.value"}}\
        {{#if content.error}}\
          {{view Ember.FormBuilder.Error text=content.error}}\
        {{/if}}\
        {{#if content.hint}}\
          {{view Ember.FormBuilder.Help text=content.hint}}\
        {{/if}}\
      {{/view}}\
    '));
    },
    errorChanged: Ember.observer(function() {
      if (this.get('error') !== void 0) return this.set('infoClass', 'error');
    }, 'error')
  });

})({});


(function(exports) {

  Ember.FormBuilder.NestedField = Ember.View.extend(Ember.Metamorph, {
    tagName: 'div',
    classNameBindings: ['classes', ':nested-fields']
  });

  Ember.FormBuilder.NestedFields = Ember.CollectionView.extend(Ember.Metamorph, {
    itemViewClass: Ember.FormBuilder.NestedField
  });

})({});


(function(exports) {

  Ember.FormBuilder.RemoveAssociation = Ember.View.extend({
    tagName: '',
    classNameBindings: ['classes'],
    template: Ember.Handlebars.compile('<a href="#" {{action "click"}}>{{text}}</a>'),
    click: function() {
      var collection, content;
      collection = this.get('collection');
      content = this.get('content');
      return collection.removeObject(content);
    }
  });

})({});


(function(exports) {



})({});
