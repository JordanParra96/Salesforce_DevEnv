({
  navToRecord: function (component) {
    var navEvt = $A.get("e.force:navigateToSObject");
    navEvt.setParams({
      recordId: component.get("v.account.Id")
    });
    navEvt.fire();
  },
  handleSuccess: function (component, helper) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
      title: "Success!",
      message: "The Account's info has been updated.",
      type: "success"
    });
    toastEvent.fire();
    var recUpdate = $A.get("e.c:recordUpdated");
    recUpdate.fire();
    helper.showHide(component);
  },
  handleCancel: function (component, event, helper) {
    helper.showHide(component);
    event.preventDefault();
  }
});
