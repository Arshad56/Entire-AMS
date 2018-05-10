/*
 *      Name            :       POLineItemPreventDelete
 *      Author          :       Mohd Anas
 *      Date            :       7th July 2017
 *      Description     :       Prevents the deletion of PO Line Item if Purchase Orde Status is not Draft or Rejected
*/
trigger POLineItemPreventDelete on PO_Line_Item__c (before delete) {
    Set<id> poIdSet = new Set<id>();
    for(PO_Line_Item__c poL: trigger.old)
        poIdSet.add(poL.purchase_order__c);
    
    
    //Map<id,String> poStatusMap = new Map<id,String>();
    List<Purchase_order__c> poList = new List<Purchase_order__c>();
    
    if(poIdSet.size()>0)
        poList = [SELECT id,Status__c from purchase_order__c where id in :poIdSet AND Status__c not in ('Draft','Rejected')];
 
  
   for(purchase_order__c po: poList)
       poIdSet.remove(po.id);
   
    
    for(PO_Line_Item__c poL: trigger.old){
        if(!poIdSet.contains(poL.Purchase_Order__c))
            poL.addError('You can only delete this record when PO status is either Draft or Rejected');
    }
}