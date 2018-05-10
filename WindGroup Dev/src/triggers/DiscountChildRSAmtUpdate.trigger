trigger DiscountChildRSAmtUpdate on Rent_Schedules__c(after update) {
    /*Set<Id> rsIds = new Set<Id>();
    for(Rent_Schedules__c rs:Trigger.New){
        if(rs.Amount__c!=Trigger.OldMap.get(rs.Id).Amount__c){
            rsIds.add(rs.Id);
        }
    }
    if(rsIds.size()>0){
        Map<Id,List<Rent_Schedules__c>> parentToChildRSMap = new Map<Id,List<Rent_Schedules__c>>();
        List<Rent_Schedules__c> childRsList = [Select id,Lease_Charge__c,Lease_Charge__r.Charge_Rate__c,Amount__c,Parent_Rent_Schedule__c,Calc_No_of_Days_Pro_Rated__c from Rent_Schedules__c where Parent_Rent_Schedule__c in:rsIds and Lease_Charge__r.Type__c='By Percent'];
        for(Rent_Schedules__c rs:childRsList){
            List<Rent_Schedules__c> tempList = new List<Rent_Schedules__c>();
            if(parentToChildRSMap.containsKey(rs.Parent_Rent_Schedule__c)){
                tempList.addAll(parentToChildRSMap.get(rs.Parent_Rent_Schedule__c));
            }
            tempList.add(rs);
            parentToChildRSMap.put(rs.Parent_Rent_Schedule__c,tempList);
        }
        
        if(parentToChildRSMap.size()>0){
            List<Rent_Schedules__c> updRsList = new List<Rent_Schedules__c>();
            for(Rent_Schedules__c parentRs:Trigger.New){
                if(parentToChildRSMap.containsKey(parentRs.Id)){
                    for(Rent_Schedules__c childRs:parentToChildRSMap.get(parentRs.Id)){
                        if(parentRs.Amount__c!=null && childRs.Lease_Charge__r.Charge_Rate__c!=null){
                            childRs.Amount__c = -(parentRs.Amount__c*childRs.Lease_Charge__r.Charge_Rate__c/100);
                            childRs.Amount__c = childRs.Amount__c.setScale(2);
                        }else{
                            childRs.Amount__c = 0;
                        }
                        updRsList.add(childRs);
                    }
                }
            }
            update updRsList;
        }
    }*/
}