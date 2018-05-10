public with sharing class MainRentRollTrigger_Helper {
    public static void sendMailToUsers(List<Rent_Roll__c> rentRolls){
    	Set<Id> propertyRelToRRIds = new Set<Id>();
    	for(Rent_Roll__c rr:rentRolls){
    		if(rr.Property__c != null || rr.Property__c != ''){
    			propertyRelToRRIds.add(rr.Property__c);
    		}
    	}
    }
}