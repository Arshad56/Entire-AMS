({
    loadEnvelopes : function(component, loadOptions) {
		// backend to be called
        var action = component.get("c.getEnvelopeStatusRecords");
		// action parameters we replace Account with Company as that's the object name we have in the DocuSign status object
		var objectName = component.get("v.sObjectName") != 'Account' ? component.get("v.sObjectName") : 'Company';
        action.setParams(
			{ "recordId" : component.get("v.recordId"), 
			  "objectName": objectName, 
			  "limitValue" : loadOptions.limit.toString(), 
			  "offsetValue" : loadOptions.offset.toString()
			 } 
		); 
		// install callback
        action.setCallback(this, function(response) {
            var state = response.getState();
			// handle success responsError
            if (component.isValid() && state === "SUCCESS") {
				
				// get and convert response to JSON
                var envelopeListString = response.getReturnValue();
                var envelopesList = JSON.parse(envelopeListString);
				var hasError = (envelopesList.error !== null) && (envelopesList.error.length > 0);

				// save envelopes
                component.set(loadOptions.attrEnvelopesList, envelopesList);
                // hide loading anyway because we got result
                $A.util.addClass(loadOptions.elemLoading, "dsfstHidden");
                // show error if we have error
                this.switchClass(loadOptions.elemError, hasError);
				// show main list and counTypeError if no error
				this.switchClass(loadOptions.elemMain, !hasError);
				this.switchClass(loadOptions.elemCount, !hasError);
				// show view all
				var showAll = (loadOptions.elemViewAll !== null) && (!hasError);
				if (showAll) {
					$A.util.removeClass(loadOptions.elemViewAll, "dsfstHidden");
				}
				// show pagination if needs 
				var showPagination = loadOptions.pagination && envelopesList.envelopes.length > 0;
				var showNextLast = this.getLastPageOffset(envelopesList.totalEnvelopes) !== loadOptions.offset;
				this.switchClass(component.find("dsfstEnvelopesFirst"), showPagination && loadOptions.offset != 0);
				this.switchClass(component.find("dsfstEnvelopesPrev"), showPagination && loadOptions.offset != 0);
				this.switchClass(component.find("dsfstEnvelopesNext"), showPagination && showNextLast);
				this.switchClass(component.find("dsfstEnvelopesLast"), showPagination && showNextLast);
				this.switchClass(component.find("dsfstEnvelopesPageInfo"), showPagination);
				if (showPagination) {
					component.set("v.paginationStartIndex", loadOptions.offset + 1);  // +1 because offset starts from 0 not from 1
					component.set("v.paginationStopIndex", loadOptions.offset + envelopesList.envelopes.length); // no +1 because first 4 is "from 1 to 4" not "from 1 to 5 (=1+4)"
				}
            }
            else if (state === "ERROR") {
				// hide loading anyway because we got result
                $A.util.addClass(loadOptions.elemLoading, "dsfstHidden");
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        throw new Error("Error loading envelopes : " + errors[0].message);
                    }
                } else {
                    throw new Error("Unknown error loading envelopes");
                }
            }
        }); 
		// nothing is loaded
		component.set(loadOptions.attrEnvelopesList, {});
        // show loading
        $A.util.removeClass(loadOptions.elemLoading, "dsfstHidden");
        // hide everything else
		$A.util.addClass(loadOptions.elemError, "dsfstHidden");
		$A.util.addClass(loadOptions.elemMain, "dsfstHidden");
		$A.util.addClass(loadOptions.elemCount, "dsfstHidden");
		// start action
        $A.enqueueAction(action);
    },

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

	/*
		show or hide specified element according to boolean flag: true - show, false - hide
	*/
	switchClass : function(/*aura element obtained by component.find*/element, /*bool*/ flag) {
		if (flag) {
			$A.util.removeClass(element, "dsfstHidden");
		} else {
			$A.util.addClass(element, "dsfstHidden");
		}
	},

	/*
		returns the page size
	*/
	getPageSize : function() {
		return 10;
	},

	/*
		returns the offset of the last page
	*/
	getLastPageOffset : function(/*int*/ totalEnvelopes) {
		/*
			if the remainder of totalEnvelope to pagesize == 0 that means we need to take a page before last
			For example: total 20 pagesize 4 last one is 5 (this is wrong, should be 20/4-1=4, so the last page starts from 16 = 4(last page) * 4(page size))
		*/
		var lastPage = Math.floor(totalEnvelopes / this.getPageSize());
		if (totalEnvelopes % this.getPageSize() === 0) {
			lastPage = lastPage - 1;
		}
		return lastPage * this.getPageSize();
	},

	setLayout : function(component) {
		//set width of the component
		var elementMain = component.find("dsfstMain");
		var contactsTwoThirdLayout = component.find("contactsTwoThirdLayout");
        var contactsOneThirdLayout = component.find("contactsOneThirdLayout");
    	if(elementMain.getElement().offsetWidth  > 600){
    		this.switchClass(contactsTwoThirdLayout, "true");
        }
        else{
    		this.switchClass(contactsOneThirdLayout, "true");
    	} 
 

	},

	getLoadingOptionDefaults : function(component, /*bool*/ isViewAll) {
		var loadOptions = {};
		if (isViewAll) {
			loadOptions.elemLoading = component.find("dsfstViewAllLoading");
			loadOptions.elemError = component.find("dsfstViewAllError");
			loadOptions.elemMain = component.find("dsfstViewAllEnvelopes");
			loadOptions.elemCount = component.find("dsfstViewAllEnvelopesCount");
			loadOptions.elemViewAll = null;
			loadOptions.attrEnvelopesList = "v.envelopesListViewAll";
			loadOptions.pagination = true;
		} else {
			loadOptions.elemLoading = component.find("dsfstLoading");
			loadOptions.elemError = component.find("dsfstError");
			loadOptions.elemMain = component.find("dsfstEnvelopes");
			loadOptions.elemCount = component.find("dsfstEnvelopesCount");
			loadOptions.elemViewAll = component.find("dsfstViewAllButton");
			loadOptions.attrEnvelopesList = "v.envelopesList";
			loadOptions.pagination = false;	
		}
		return loadOptions;
	}

})