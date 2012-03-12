(function() {
  var appendView, get, getPath, input, set,
    __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  get = Ember.get;

  set = Ember.set;

  getPath = Ember.getPath;

  input = null;

  appendView = function(v) {
    return Ember.run(function() {
      return v.appendTo('#qunit-fixture');
    });
  };

  module("Ember.FormBuilder.Input", {
    setup: function() {
      return input = Ember.FormBuilder.Input.create();
    },
    teardown: function() {
      return input = null;
    }
  });

  test("be set under the appropriate default wrapper", function() {
    var cls, tag;
    tag = Ember.FormBuilder.wrapperTag;
    if (tag) ok(input.tagName === tag);
    appendView(input);
    cls = Ember.FormBuilder.wrapperClass;
    if (cls) return ok(input.$().hasClass(cls), "should have class " + cls);
  });

  test("be set under the appropriate custom wrapper", function() {
    var cls, tag;
    tag = 'span';
    input.set('tagName', tag);
    cls = 'custom';
    input.set('wrapperClass', cls);
    if (tag) ok(input.tagName === tag);
    appendView(input);
    if (cls) return ok(input.$().hasClass(cls), "should have class " + cls);
  });

  test("have the input wrapper", function() {
    appendView(input);
    return ok(input.$().find(Ember.FormBuilder.inputWrapperTag).hasClass(Ember.FormBuilder.inputWrapperClass));
  });

  test("generates aa input tag", function() {
    appendView(input);
    return ok(input.$('input').length === 1);
  });

  test("binds value correctly", function() {
    var myValue;
    myValue = "";
    input.set('valueBinding', 'myValue');
    appendView(input);
    input.$('input').val('test');
    input.inputView.change();
    return setTimeout(200, function() {
      console.log(myValue);
      return ok(myValue === 'test');
    });
  });

  test("has a label", function() {
    appendView(input);
    return ok(input.$('label').length === 1);
  });

  test("does not have a label when i dont want to", function() {
    input.set('showLabel', false);
    appendView(input);
    return ok(input.$('label').length === 0);
  });

  test("shows errors and hints", function() {
    var errorSelector, hintSelector;
    input.set('error', "must me valid");
    input.set('hint', "test@example.com");
    appendView(input);
    errorSelector = "" + Ember.FormBuilder.errorTag + "." + Ember.FormBuilder.errorClass;
    ok(input.$(errorSelector).length === 1);
    ok(input.$(errorSelector).text() === "must me valid");
    ok(input.$().hasClass('error'));
    hintSelector = "" + Ember.FormBuilder.helpTag + "." + Ember.FormBuilder.helpClass;
    ok(input.$(hintSelector).length === 1);
    return __indexOf.call(input.$(hintSelector).text(), ok) >= 0 === "test@example.com";
  });

  test("works for textarea", function() {
    input.set('inputViewClass', Ember.TextArea);
    appendView(input);
    return ok(input.$('textarea').length === 1);
  });

  test("works for checkbox", function() {
    input.set('inputViewClass', Ember.Checkbox);
    appendView(input);
    return ok(input.$('input[type=checkbox]').length === 1);
  });

}).call(this);
