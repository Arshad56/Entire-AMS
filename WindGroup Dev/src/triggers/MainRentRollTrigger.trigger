trigger MainRentRollTrigger on Rent_Roll__c (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
    	 MainRentRollTrigger_Helper.sendMailToUsers(Trigger.new);
    }
}