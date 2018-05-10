/*  
    Name         : PurchaseOrderTrigger 
    Author       : Rajesh 
    Created Date : 2nd Jun 2017   
    Description  : This trigger is used to rollup amount based on Status picklist field value in Purchase_Order__c object if picklist value is ‘IN-Approval’
                      then update total rollup amount in 'PO Pending',‘Issued’then update total rollup amount in 'PO Issued'.
*/
trigger PurchaseOrderTrigger on Purchase_Order__c (after update) {
    Set<Id> purOrdrIds = new Set<Id>();
    
    for(Purchase_Order__c purOrdr : Trigger.New){
        if(purOrdr.Status__c != Trigger.OldMap.get(purOrdr.Id).Status__c)
            purOrdrIds.add(purOrdr.Id);
    }
    
    if(purOrdrIds.size() > 0){
        RollupPurchaseOrderItemHelper.rollupPurOrdrItmAmount(purOrdrIds);
    }
    
}