({
	afterRender: function (component, helper) {
		var afterRend = this.superAfterRender();
		helper.setLayout(component);
		return afterRend;
	},
})