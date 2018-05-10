({

	// called when user clicks a link
	redirectToSObject: function (component, event, helper) {
		// obtains salesforce id from attribute
		var salesforceId = event.target.getAttribute('data-sfid');
		// create redirect event
        window.open('/'+salesforceId);
	},



	//called when mouseover event of status 
	showRoutingOrder: function(component, event, helper){
		var cmpTarget = component.find('dsfstViewRoutingOrder');
		$A.util.removeClass(cmpTarget, "dsfstHidden");
	},

	//called when mouseout event of status 
	hideRoutingOrder: function(component, event, helper){
		var cmpTarget = component.find('dsfstViewRoutingOrder');
		$A.util.addClass(cmpTarget, "dsfstHidden");
	},
	
	//called when mouseover event of last activity 
	showLastActivity: function(component, event, helper){
		var cmpTarget = component.find('dsfstViewLastActivity');
		$A.util.removeClass(cmpTarget, "dsfstHidden");
	},

	//called when mouseout event of last activity 
	hideLastActivity: function(component, event, helper){
		var cmpTarget = component.find('dsfstViewLastActivity');
		$A.util.addClass(cmpTarget, "dsfstHidden");
	},

	openDetailModal : function(component, event, helper) {
		// show modal
		var modalType = event.target.getAttribute('data-sfid');
		var routingOrderModelContent = component.find('dsfstViewRoutingOrderModal');
		var lastActivityModelContent = component.find('dsfstViewLastActivityModal');
		if(modalType == 'routingOrder'){		
			$A.util.removeClass(routingOrderModelContent, 'dsfstHidden');
			$A.util.addClass(lastActivityModelContent, 'dsfstHidden');
		}else if(modalType == 'lastActivity'){			
			$A.util.removeClass(lastActivityModelContent, 'dsfstHidden');
			$A.util.addClass(routingOrderModelContent, 'dsfstHidden');
		}
		helper.toggleClass(component,'viewAllContentBackdrop', 'slds-backdrop--');
		helper.toggleClass(component,'viewAllContentRoutingOrder', 'slds-fade-in-');
	},
	closeDetailModal : function(component, event, helper) {
		helper.toggleClassInverse(component,'viewAllContentBackdrop', 'slds-backdrop--');
		helper.toggleClassInverse(component,'viewAllContentRoutingOrder', 'slds-fade-in-');
	}	
})