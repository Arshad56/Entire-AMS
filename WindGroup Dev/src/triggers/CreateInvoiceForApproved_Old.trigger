trigger CreateInvoiceForApproved_Old on Rent_Roll__c (after update) {
    /*Set<Id> rentRollIds = new Set<Id>();
    for(Rent_Roll__c rr:Trigger.New){
        if(rr.Approved__c && rr.Approved__c!=Trigger.OldMap.get(rr.Id).Approved__c){
            rentRollIds.add(rr.Id);
        }
    }
    if(rentRollIds.size()>0){
        map<Id,map<Id,List<Rent_Schedules__c>>> rentrollToScheduleMap = new map<Id,map<Id,List<Rent_Schedules__c>>>();
        List<Rent_Schedules__c> rentSchedules = [Select id,Name,Amount__c,Rent_Roll__c,Lease_Unit__r.Lease_Agreement_No__c,Lease_Unit__r.Lease_Agreement_No__r.Tenant__c,Tenant__c,Lease_Charge__r.Charge_Description__c,recordType.Name from Rent_Schedules__c where Rent_Roll__c in:rentRollIds and Approved__c=true];
        if(rentSchedules.size()>0){
             for(Rent_Schedules__c rs:rentSchedules){
                 Map<Id,List<Rent_Schedules__c>> tempMap = new Map<Id,List<Rent_Schedules__c>>();
                 List<Rent_Schedules__c> tempList = new List<Rent_Schedules__c>();
                 if(rentrollToScheduleMap.containsKey(rs.Rent_Roll__c)){
                     tempMap = rentrollToScheduleMap.get(rs.Rent_Roll__c);
                     if(tempMap.containsKey(rs.Lease_Unit__r.Lease_Agreement_No__c)){
                         tempList.addAll(tempMap.get(rs.Lease_Unit__r.Lease_Agreement_No__c));
                     }
                 }
                 tempList.add(rs);
                 tempMap.put(rs.Lease_Unit__r.Lease_Agreement_No__c,tempList);
                 rentrollToScheduleMap.put(rs.Rent_Roll__c,tempMap);
             }
        }
        
        if(rentrollToScheduleMap.size()>0){
            List<Invoicewrapper> invWrapperList = new List<Invoicewrapper>();
            for(Rent_Roll__c rr:Trigger.New){
                if(rentrollToScheduleMap.containsKey(rr.Id)){
                    Map<Id,List<Rent_Schedules__c>> tempMap = rentrollToScheduleMap.get(rr.Id);
                    for(Id leaseId:tempMap.keyset()){
                        Invoicewrapper invWrap = new Invoicewrapper();
                        Invoice__c inv = new Invoice__c();
                        inv.Rent_Roll__c = rr.Id;
                        inv.Status__c = 'Ready';
                        inv.Invoice_Type__c = 'System Generated Invoice';
                        inv.Lease__c = leaseId;
                        string billingType;
                        for(Rent_Schedules__c rs:tempMap.get(leaseId)){
                            if(billingType==null){
                                billingType = rs.recordType.Name;
                            }
                            Invoice_Line_Item__c invLinItm = new Invoice_Line_Item__c();
                            invLinItm.Rent_Schedule__c = rs.Id;
                            invLinItm.Description__c = rs.Lease_Charge__r.Charge_Description__c;
                            invLinItm.Amount__c = rs.Amount__c;
                            invWrap.invLineItemList.add(invLinItm);
                        }
                        if(rr.Rent_Roll_MM__c!=null && rr.Rent_Roll_YYYY__c!=null){
                            if(billingType==label.RentScheduleRentRecordType){
                                inv.Invoice_Date__c = Date.newInstance(Integer.valueOf(rr.Rent_Roll_YYYY__c),Integer.valueOf(rr.Rent_Roll_MM__c),1);
                            }else if(billingType==label.RentScheduleMonthlyRecordType){
                                inv.Invoice_Date__c = Date.newInstance(Integer.valueOf(rr.Rent_Roll_YYYY__c),Integer.valueOf(rr.Rent_Roll_MM__c),25);
                            }
                            inv.Payment_Due_Date__c = inv.Invoice_Date__c.addDays(7);
                        }
                        invWrap.inv = inv;
                        invWrapperList.add(invWrap);
                    }
                }
            }
            if(invWrapperList.size()>0){
                List<Invoice__c> invList = new List<Invoice__c>();
                for(Invoicewrapper iw:invWrapperList){
                    invList.add(iw.inv);
                }
                insert invList;
                List<Invoice_Line_Item__c> invLinItms = new List<Invoice_Line_Item__c>();
                for(Invoicewrapper iw:invWrapperList){
                    for(Invoice_Line_Item__c invLinItm:iw.invLineItemList){
                        invLinItm.Invoice__c = iw.inv.Id;
                        invLinItms.add(invLinItm);
                    }
                }
                insert invLinItms;
            }
        }
    }
    
    class Invoicewrapper{
        Invoice__c inv;
        List<Invoice_Line_Item__c>  invLineItemList;
        Invoicewrapper(){
            inv = new Invoice__c();
            invLineItemList = new List<Invoice_Line_Item__c>(); 
        }
    }*/
}