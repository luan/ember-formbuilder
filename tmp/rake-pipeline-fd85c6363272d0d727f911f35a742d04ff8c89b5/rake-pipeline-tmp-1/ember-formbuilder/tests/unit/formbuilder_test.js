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

  module("Ember.FormBuilder", {
    setup: function() {
      return form = Ember.FormBuilder.create();
    },
    teardown: function() {
      return form = null;
    }
  });

  test("can have a property set on it", function() {
    set(form, 'name', 'bar');
    return equal(get(form, 'name'), 'bar', "property was set on the form");
  });

  test("generates a form class", function() {
    return ok(form.tagName === 'form', "should have inserted a form tag.");
  });

  test("displays children when template has them", function() {
    set(form, 'template', Handlebars.compile("<input type=\"text\" /><input type=\"text\" />"));
    appendView(form);
    return ok(form.$().find('input').length === 2, "should have children.");
  });

}).call(this);
