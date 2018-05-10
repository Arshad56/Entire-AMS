trigger UpdateLeasePlans on Lease_Plan__c (before insert, before update) {
    if(Utility.updateLPRun){
    	Utility.updateLPRun = false;
        Integer endOfMonth=0;
        for(Lease_Plan__c lp: Trigger.new){
            endOfMonth=0;
            if(lp.Unit__c != null)
	            if(lp.End_Date__c != null){
	                endOfMonth = lp.End_Date__c.Day();
	                for(Integer j = 1; j <= endOfMonth; j++){
	                	if(Trigger.isInsert){
	                		if(lp.Monthly_Budget__c > 0)
	                          lp.put('Daily_Rate_'+j+'__c',(lp.Monthly_Budget__c != null)?lp.Monthly_Budget__c/endOfMonth:0);
		                }else if(Trigger.isUpdate){
		                    if(lp.Monthly_Budget__c != Trigger.oldMap.get(lp.Id).Monthly_Budget__c){
		                         lp.put('Daily_Rate_'+j+'__c',(lp.Monthly_Budget__c != null)?lp.Monthly_Budget__c/endOfMonth:0);
		                    }
		                }
	                }
	            }
        }
    }
}