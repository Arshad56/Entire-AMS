({
	toggleClass: function(component, componentId, className) {
		var modal = component.find(componentId);
		$A.util.removeClass(modal, className + 'hide');
		$A.util.addClass(modal, className + 'open');
	},

	toggleClassInverse: function(component, componentId, className) {
		var modal = component.find(componentId);
		$A.util.addClass(modal, className + 'hide');
		$A.util.removeClass(modal, className + 'open');
	},    
    
	getLoadingOptionDefaults : function(component, /*bool*/ isViewAll) {
		var loadOptions = {};
		if (isViewAll) {
			loadOptions.elemLoading = component.find("dsfstViewAllLoading");
			loadOptions.elemError = component.find("dsfstViewAllError");
		} else {
			loadOptions.elemLoading = component.find("dsfstLoading");
			loadOptions.elemError = component.find("dsfstError");
		}
		return loadOptions;
	}    
})