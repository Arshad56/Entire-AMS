trigger PurchaseOrderThreeQuoteValidation on Purchase_Order__c (before update) {
    for(Purchase_Order__c po : trigger.new){
        if((po.Status__c == 'In-Approval' || po.Status__c == 'Issued') && po.PO_Amount__c>=Integer.valueOf(System.Label.Purchase_Order_Quote_Amount_Validation) && !po.X3_Quotes__c)
            //po.id.addError('Error : Kindly follow 3 Quote process as PO Amount exceed allocated Budget. Please click <a href="/po.id">here</a> to go back to PO record.',false);
            po.addError('Error : Kindly follow 3 Quote process as PO Amount exceed allocated budget. Please click on the browser back button for go back to PO record.', false);
     }              
}