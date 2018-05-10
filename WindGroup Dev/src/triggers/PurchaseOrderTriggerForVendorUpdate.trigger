/*  
*   Name         : PurchaseOrderTriggerForVendorUpdate 
*   Author       : Mohd Anas 
*   Created Date : 27th Jun 2017   
*   Description  : This trigger is used to delete po payment arrangement under purchase order whenever the vendor account is changed.
*/

trigger PurchaseOrderTriggerForVendorUpdate on Purchase_Order__c (before update) {
    Set<id> poIdSet = new Set<id>();
    for(Purchase_Order__c po :trigger.new){
        if(po.vendor_name__c != trigger.oldMap.get(po.id).vendor_name__C)
            poIdSet.add(po.id);
    }
    
    List<PO_payment_Arrangement__c> poPaymentArraList = new List<PO_payment_Arrangement__c>();
    if(poIdSet.size()>0)
        poPaymentArraList = [select id from PO_payment_Arrangement__c where Purchase_Order__c in :poIdSet];
    if(poPaymentArraList.size()>0)
        delete poPaymentArraList;
}