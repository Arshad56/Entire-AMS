trigger GeneratePurchaseOrderPDF on Purchase_Order__c (after update){
    Set<Id> pOrderIdSet = new Set<Id>();
    for(Purchase_order__c pOrder : trigger.New){
        Boolean oldState = trigger.oldMap.get(pOrder.id).Generate_PO_PDF__c;
        if(pOrder.Generate_PO_PDF__c && pOrder.Generate_PO_PDF__c != oldState)
            pOrderIdSet.add(pOrder.Id);
    }
    
    if(pOrderIdSet.size()>0)
            DownloadPurchaseOrder.generatePDFAsAttachment(pOrderIdSet);
    
}