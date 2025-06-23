({
  updateValue: function (component) {
    var val = component.find("myInput").getElement().value;
    component.set("v.greeting", val);
  }
});
