trigger SendEmailNotificationToFinance on Rent_Roll__c (after insert) {
    if(Trigger.isInsert && Trigger.isAfter){
    	set<Id> rrIds= new set<Id>();
    	set<Id> propIds= new set<Id>();
    	for(Rent_Roll__c rr: trigger.new){
    		if(rr.Property__c != null){
    			rrIds.add(rr.Id);
    			propIds.add(rr.Property__c);
    		}
    	}
    	///list<Rent_Roll__Share> rrShare = [select id from Rent_Roll__Share where ParentId in: rentSchIds and RowCause <> 'Owner' and AccessLevel = 'Edit'];
    	/*
    	Messaging.reserveSingleEmailCapacity(trigger.size);
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (Contact c : trigger.new) { // walk through all records which is processed
            Contact old = trigger.oldMap.get(c.Id); // get old record from oldMap
            if (old.Email != c.Email ) { // check current email 
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] {c.Email};);
                email.setReplyTo('XXX@example.com');
                email.setSenderDisplayName('Mr Apex Tester');
                email.setSubject('Subjected to Learning');
                email.setPlainTextBody('You have just changed your SalesForce contact email from ' + 
                    old.Email + ' to ' + c.Email +
                     '. If this was not intentional please log back into Salesforce.com and ammend you details.');
                emails.add(email);
            }
        }
        Messaging.sendEmail(emails);
    }
    */
    }
}


/*trigger PropertySharingFromRentRoll on Rent_Roll__c (after insert) {
	Set<Id> propId= new Set<Id>();
    for(Rent_Roll__c rr:[Select id,name,Property__c from Rent_Roll__c where Id =: Trigger.newMap.KeySet()]){
	if(rr.Property__c != null){
	      propId.add(rr.Property__c);
	} 
	} 
	if(propId.size() > 0){
	PropertyChildRecordSharing_Utility.shareTheseRecords(propId,Trigger.new);
	
	list<Rent_Roll__Share> rrShare = [select id from Rent_Roll__Share where ParentId in: rentSchIds and RowCause <> 'Owner' and AccessLevel = 'Edit'];
	
	}
}*/