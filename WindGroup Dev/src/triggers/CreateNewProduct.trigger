trigger CreateNewProduct on Purchase_Order__c (before update,after update) {
    if(Trigger.isBefore){
        for(Purchase_Order__c po:Trigger.New){
            if(po.Status__c=='In-Approval' && po.Status__c!=Trigger.oldMap.get(po.Id).Status__c){
                po.PO_Line_Validation_Bypass__c = true;
            }
        }    
    }else{
        Set<Id> poIds = new Set<Id>();
        for(Purchase_Order__c po:Trigger.New){
            if(po.Status__c=='In-Approval' && po.Status__c!=Trigger.oldMap.get(po.Id).Status__c){
                poIds.add(po.Id);
            }
        }
        if(poIds.size()>0){
            Map<Id,List<PO_Line_Item__c>> poToLineItmMap = new Map<Id,List<PO_Line_Item__c>>();
            for(PO_Line_Item__c pli:[Select id,Purchase_Order__c,Item_Name__c,Description__c,Amount__c,Product_Type__c,Department__c from PO_Line_Item__c where Purchase_Order__c in:poIds and Product_Catalogue__c=null and Item_Name__c!=null]){
                List<PO_Line_Item__c> tempList = new List<PO_Line_Item__c>();
                if(poToLineItmMap.containsKey(pli.Purchase_Order__c)){
                    tempList.addAll(poToLineItmMap.get(pli.Purchase_Order__c));
                }
                tempList.add(pli);
                poToLineItmMap.put(pli.Purchase_Order__c,tempList);
            }
            if(poToLineItmMap.size()>0){
                Map<string,Item_Catalogue__c> prodCatMap = new Map<string,Item_Catalogue__c>();
                for(Purchase_Order__c po:Trigger.New){
                    if(poIds.contains(po.Id) && poToLineItmMap.containsKey(po.Id)){
                        for(PO_Line_Item__c pli:poToLineItmMap.get(po.Id)){
                            Item_Catalogue__c prodCat = new Item_Catalogue__c();
                            prodCat.Name = pli.Item_Name__c;
                            prodCat.Description__c = pli.Description__c;
                            prodCat.Amount__c = pli.Amount__c;
                            prodCat.Vendor_Name__c = po.Vendor_Name__c;
                            prodCat.Expiry_Date__c = system.Today().addYears(1);
                            prodCat.Product_Type__c = pli.Product_Type__c;
                            prodCat.Department__c = pli.Department__c;
                            prodCat.Status__c = 'Active';
                            prodCatMap.put(prodCat.Name,prodCat);
                        }
                    }
                }
                if(prodCatMap.size()>0){
                    insert prodCatMap.values();
                    
                    List<PO_Line_Item__c> lineItemList = new List<PO_Line_Item__c>();
                    for(Purchase_Order__c po:Trigger.New){
                        if(poIds.contains(po.Id) && poToLineItmMap.containsKey(po.Id)){
                            for(PO_Line_Item__c pli:poToLineItmMap.get(po.Id)){
                                if(prodCatMap.containsKey(pli.Item_Name__c)){
                                    pli.Product_Catalogue__c = prodCatMap.get(pli.Item_Name__c).Id;
                                    lineItemList.add(pli);
                                }
                            }
                        }
                    }
                    if(lineItemList.size()>0){
                        update lineItemList;
                    }
                }
            }
        }
        List<Purchase_Order__c> updatePOList = new List<Purchase_Order__c>();
        for(Purchase_Order__c po:Trigger.New){
            if(poIds.contains(po.Id)){
                Purchase_Order__c updPO = new Purchase_Order__c();
                updPo.Id = po.Id;
                updPo.PO_Line_Validation_Bypass__c = false;
                updatePOList.add(updPo);
            }
        }
        if(updatePOList.size()>0){
            update updatePOList;
        }
    }
}