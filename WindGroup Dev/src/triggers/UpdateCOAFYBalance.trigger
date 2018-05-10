/*
* Name             :       UpdateCOAFYBalance
* Author           :       Mohd Anas
* Date             :       05 June 2017
* Description      :       Apex Trigger To populate COA FY Balance in purchase order line Item
*/
trigger UpdateCOAFYBalance on PO_Line_Item__c (before insert,before update){

    Map<id,String> purOrderTobudgetLine = new Map<id,String>();
    Set<string> departmentSet = new Set<String>();
    Map<Id,Set<String>> companyNameToDates = new Map<Id,Set<String>>();
    Map<id,COA_FY_Balance__c>  finalMap= new  Map<id,COA_FY_Balance__c>();
    
    for(PO_Line_Item__c po : trigger.new){
        purOrderTobudgetLine.put(po.Purchase_Order__c,po.Budget_Line__c);
        departmentSet.add(po.Department__c);
    }
    
    
    for(Purchase_Order__c prOrd : [Select company_name__c,PO_Start_Date__c,PO_End_Date__c from Purchase_Order__c where id in :purOrderTobudgetLine.keySet()]){
        if(companyNameToDates.containsKey(prOrd.company_name__c)){
            Set<String> tempSet = companyNameToDates.get(prOrd.company_name__c);
            String str=prOrd.id+','+prOrd.PO_Start_Date__c;
            tempSet.add(str);
            companyNameToDates.put(prOrd.company_name__c,tempSet);
        }
        else{
            Set<String> temp = new Set<String>();
            String str=prOrd.id+','+prOrd.PO_Start_Date__c;
            temp.add(str);
            companyNameToDates.put(prOrd.company_name__c,temp);
        }

    }
    
    for(Operational_budget__c opr: [Select company_name__c,Budget_Line__c,(select id,Fiscal_Year__r.End_Date__c,Fiscal_Year__r.Start_Date__c,Budget_Balance__c from COA_FY_Balance__r) from Operational_budget__c where Budget_Line__c in : purOrderTobudgetLine.values() and Department__c in:departmentSet and company_name__c in :companyNameToDates.keyset()] ){
        if(companyNameToDates.containskey(opr.Company_Name__c)){
            for(String st :companyNameToDates.get(opr.company_name__c)){
                List<String> tempPurchaseOrderMap = st.split(',');
                for(COA_FY_Balance__c coaBal: opr.COA_FY_Balance__r){
                    if(String.valueOf(coaBal.Fiscal_Year__r.End_Date__c) >= tempPurchaseOrderMap[1] && String.valueOf(coaBal.Fiscal_Year__r.Start_Date__c) <= tempPurchaseOrderMap[1]){
                        finalMap.put(tempPurchaseOrderMap[0],coaBal);
                    }
                }                
             }
        }
    }
    
    for(PO_Line_Item__c po : trigger.new){
        if(finalMap.containsKey(po.Purchase_order__c)){
            po.COA_FY_Balance__c = finalMap.get(po.Purchase_order__c).Id;
            Decimal totalAmount = (po.Amount__c!=null && po.Quantity__c!=null?po.Quantity__c*po.Amount__c:0);
            if(totalAmount > finalMap.get(po.Purchase_order__c).Budget_Balance__c){
                po.addError('Total Amount should not exceed Budget of COA FY Balance record.');
            }
        }
    }
   
    
}