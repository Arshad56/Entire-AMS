({
    init : function(component, event, helper) {
		var MAIN_VIEW_PAGE_SIZE = 3;
		var loadOptions = helper.getLoadingOptionDefaults(component, false);
		loadOptions.limit = MAIN_VIEW_PAGE_SIZE;
		loadOptions.offset = 0;
        helper.loadEnvelopes(component, loadOptions);
    },
	
	openViewAll : function(component, event, helper) {
		// load envelopes
		var loadOptions = helper.getLoadingOptionDefaults(component, true);
		loadOptions.limit = helper.getPageSize();
		loadOptions.offset = 0;
		helper.loadEnvelopes(component, loadOptions);
		// show modal
		helper.toggleClass(component,'viewAllContentBackdrop', 'slds-backdrop--');
		helper.toggleClass(component,'viewAllContent', 'slds-fade-in-');
	}, 

	closeViewAll : function(component, event, helper) {
		helper.toggleClassInverse(component,'viewAllContentBackdrop', 'slds-backdrop--');
		helper.toggleClassInverse(component,'viewAllContent', 'slds-fade-in-');
	},

	pageFirst : function(component, event, helper) {
		var loadOptions = helper.getLoadingOptionDefaults(component, true);
		loadOptions.limit = helper.getPageSize();
		loadOptions.offset = 0;
		helper.loadEnvelopes(component, loadOptions);
	},

	pagePrev : function(component, event, helper) {
		var loadOptions = helper.getLoadingOptionDefaults(component, true);
		loadOptions.limit = helper.getPageSize();
		loadOptions.offset = component.get("v.paginationStartIndex") - 1 - helper.getPageSize();
		helper.loadEnvelopes(component, loadOptions);
	},

	pageNext : function(component, event, helper) {
		var loadOptions = helper.getLoadingOptionDefaults(component, true);
		loadOptions.limit = helper.getPageSize();
		loadOptions.offset = component.get("v.paginationStartIndex") - 1 + helper.getPageSize();
		helper.loadEnvelopes(component, loadOptions);
	},

	pageLast : function(component, event, helper) {
		var loadOptions = helper.getLoadingOptionDefaults(component, true);
		loadOptions.limit = helper.getPageSize();
		var totalEnvelopes = component.get("v.envelopesListViewAll").totalEnvelopes;
		loadOptions.offset = helper.getLastPageOffset(totalEnvelopes);
		helper.loadEnvelopes(component, loadOptions);
	}
})