(function() {
  var appendView, form, get, getPath, set;

  get = Ember.get;

  set = Ember.set;

  getPath = Ember.getPath;

  form = null;

  appendView = function(v) {
    return Ember.run(function() {
      return v.appendTo('#qunit-fixture');
    });
  };

  module("Ember.FormBuilder.Form", {
    setup: function() {
      return form = Ember.FormBuilder.Form.create();
    },
    teardown: function() {
      return form = null;
    }
  });

  test("can have a property set on it", function() {
    set(form, 'name', 'bar');
    return equal(get(form, 'name'), 'bar', "property was set on the form");
  });

  test("generates a form tag", function() {
    return ok(form.tagName === 'form', "should have inserted a form tag.");
  });

  test("displays children when template has them", function() {
    set(form, 'template', Handlebars.compile("<input type=\"text\" /><input type=\"text\" />"));
    appendView(form);
    return ok(form.$().find('input').length === 2, "should have children.");
  });

  test("has the class names specified", function() {
    var classes, cls, _i, _len, _ref, _results;
    classes = 'form-horizontal class1 class2';
    set(form, 'classes', classes);
    appendView(form);
    _ref = classes.split(' ');
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      cls = _ref[_i];
      _results.push(ok(form.$().hasClass(cls), "form should have class " + cls));
    }
    return _results;
  });

}).call(this);
