/*
*    Name           :    ThreeDimensionalCheckForInvoiceReceipt
*    Author         :    Mohd Anas
*    Date           :    29th June 2017
*    Description    :    This trigger checks the following scenario
*                        1. Invoice ammount doesnt exceeds the good receipt
*                        2. Invoice ammount doesnt voilates the payment arrangement
*                        3. Update the checkbox ("Invoice Created") in Po Payment arrangement
*                        4. Invoice must be generated in sequence of payment arrangement (EDITTED ON : 14th July 2014)  
*/

trigger ThreeDimensionalCheckForInvoiceReceipt on Invoice_Receipt__c (before insert,before delete) {
   if(Trigger.isInsert){
       Map<Id,PO_Payment_Arrangement__c> poPaymentArrMap = new Map<Id,PO_Payment_Arrangement__c>();
       Map<String,Decimal> poInvoiceReciptMap = new Map<String,Decimal>();
       Map<Id,Decimal> poToSequence = new Map<Id,Decimal>();
        
       for(Invoice_Receipt__c inv : trigger.new){
           if(inv.PO_Payment_Arrangement__c != null)
               poPaymentArrMap.put(inv.PO_Payment_Arrangement__c,null);
           
           if(inv.Purchase_Order__c!= null)
               poInvoiceReciptMap.put(inv.Purchase_Order__c,inv.Amount__c != null ? inv.Amount__c : 1); 
       }
       System.debug('poInvoiceReciptMap.keySet()--@@'+poInvoiceReciptMap.keySet());
       if(poPaymentArrMap.size() > 0){
           poPaymentArrMap = new Map<Id,PO_Payment_Arrangement__c>([SELECT id,Payment_Term__c,PO_Amount__c,Purchase_Order__c,Purchase_Order__r.Received_Amount__c,Seq_No__c 
                                                                   from PO_Payment_Arrangement__c where id in :poPaymentArrMap.keySet() And Purchase_Order__c != null]);
           
           if(poPaymentArrMap.size()>0){
               //--------------------------MAP filling for-------Sequence checking Error-----------------------------
               for(Po_Payment_Arrangement__c pa :poPaymentArrMap.values())
                   poToSequence.put(pa.purchase_order__c,pa.Seq_No__c!=null?pa.Seq_No__c:0);
                   
                   
               for(AggregateResult ar: [SELECT Purchase_Order__c, SUM(Amount__c) invRoll
                                                      FROM Invoice_Receipt__c WHERE Purchase_Order__c IN:poInvoiceReciptMap.keySet()
                                                      GROUP BY Purchase_Order__c]){
                   String poId = String.valueOf(ar.get('Purchase_Order__c'));
                   Decimal invPoRollup = Double.valueOf(ar.get('invRoll'));
                   
                   if(poInvoiceReciptMap.containskey(poId))
                       poInvoiceReciptMap.put(poId,poInvoiceReciptMap.get(poId)+invPoRollup);
                   else    
                       poInvoiceReciptMap.put(poId,invPoRollup);
               }
           }
           //--------------------------------------------Sequence checking Block-----------------------------
           Map<id,Boolean> seqErr = new Map<id,Boolean>();
           if(poToSequence.size()>0){
               for(PO_Payment_Arrangement__c poSeq : [SELECT purchase_order__c,Seq_No__c,Invoice_created__c 
                                                             FROM PO_Payment_Arrangement__c 
                                                             WHERE purchase_order__c in :poToSequence.keyset()]){
    
                    if(poToSequence.containsKey(poSeq.Purchase_Order__c) && poSeq.Seq_No__c != NULL){
                        if(poSeq.Seq_No__c<poToSequence.get(poSeq.Purchase_Order__c)){
                            if(!poSeq.Invoice_created__c){
                                if(seqErr.containsKey(poSeq.Purchase_Order__c) && !seqErr.get(poSeq.Purchase_Order__c))
                                    seqErr.put(poSeq.Purchase_Order__c,True);
                                else
                                    seqErr.put(poSeq.Purchase_Order__c,True);
                            }
                        }
                    }
               }
           }
           //----------------------------------------END OF----Sequence checking Block-----------------------------
           List<PO_Payment_Arrangement__c > poPaymentList = new List<PO_Payment_Arrangement__c >();
           
           for(Invoice_Receipt__c inv : trigger.new){
               Boolean isErrr = False;
               //---------------------------------Sequence checking Error-----------------------------
               if(seqErr.size()>0)
                   if(seqErr.containsKey(inv.Purchase_Order__c)  && seqErr.get(inv.Purchase_Order__c))
                       inv.addError('Error : Invoice can only be created in sequence');
               //------------------------END ---------Sequence checking Error-----------------------------
               Decimal payArrAmount = poPaymentArrMap.get(inv.PO_Payment_Arrangement__c).PO_Amount__c;
               
               if(inv.Amount__c >  payArrAmount){
                   inv.addError('Error : Invoice Amount exceeds Payment Arrangement Amount');
                   isErrr = True; 
               }else if(inv.Amount__c <  payArrAmount){
                   inv.addError('Error : Invoice Amount preceeds Payment Arrangement Amount');
                   isErrr = True;
               }else{
                   Decimal goodReciAmt  = poPaymentArrMap.get(inv.PO_Payment_Arrangement__c).Purchase_Order__r.Received_Amount__c;
                   Decimal invReceiptRollupAmt = poInvoiceReciptMap.get(inv.Purchase_Order__c);
                   
                   if(invReceiptRollupAmt > goodReciAmt){
                       inv.addError('Error : Total of Invoice Receipt(s) cannot exceed PO: Received Amount');
                       isErrr = True;
                   }
               }   
               
               if(!isErrr)
                   poPaymentList.add(new PO_Payment_Arrangement__c(id=inv.PO_Payment_Arrangement__c,invoice_created__c = true));            
           }
            
           if(poPaymentList.size()>0){
                List<Purchase_order__c> poToUpdate = new List<Purchase_order__C>();
                boolean changedToValidate = false;
                for(Purchase_Order__c po : [SELECT PO_Line_Validation_Bypass__c 
                                                FROM Purchase_Order__c 
                                                WHERE id in :poInvoiceReciptMap.keySet()]){
                    if(!po.PO_Line_Validation_Bypass__c){
                        changedToValidate = true;
                        po.PO_Line_Validation_Bypass__c = True;
                        poToUpdate.add(po);
                    }
                 }
                 update poToUpdate;
                 update poPaymentList;
                 if(changedToValidate){
                     for(Purchase_Order__c po : poToUpdate)
                         po.PO_Line_Validation_Bypass__c = false;
                      update poToUpdate; 
                  }
           }
       }
   }
    /*
    if(Trigger.isDelete){
        for(Invoice_Receipt__c inv : trigger.old){
            if(inv.po_payment_Arrangement != NULL)
                
        }
    }*/ 
}