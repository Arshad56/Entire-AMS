trigger DiscountRsAmountCheck on Rent_Schedules__c (before update) {
    /*Set<Id> parentRsIds = new Set<Id>();
    Set<Id> lcIds = new Set<Id>();
    for(Rent_Schedules__c rs:Trigger.New){
        if(rs.Charge_Type__c=='Discount'){
            parentRsIds.add(rs.parent_Rent_Schedule__c);
            lcIds.add(rs.Lease_Charge__c);
        }
    }
    if(parentRsIds.size()>0 && lcIds.size()>0){
        Map<Id,Rent_Schedules__c> parentRsMap = new Map<Id,Rent_Schedules__c>([Select id,Amount__c from Rent_Schedules__c where id in:parentRsIds]);
        Map<Id,Lease_Charges__c> leaseChargeMap = new Map<Id,Lease_Charges__c>([Select id,Type__c,Charge_Rate__c from Lease_Charges__c where id in:lcIds]);
        
        for(Rent_Schedules__c rs:Trigger.New){
            if(rs.Charge_Type__c=='Discount' && parentRsMap.containsKey(rs.parent_Rent_Schedule__c) && leaseChargeMap.containsKey(rs.Lease_Charge__c)){
                if(leaseChargeMap.get(rs.Lease_Charge__c).Type__c=='Fixed'){
                    if(leaseChargeMap.get(rs.Lease_Charge__c).Charge_Rate__c!=null){
                        rs.Amount__c = -(leaseChargeMap.get(rs.Lease_Charge__c).Charge_Rate__c);
                        rs.Amount__c = rs.Amount__c.setScale(2);
                    }else{
                        rs.Amount__c = 0;
                    }
                }else if(leaseChargeMap.get(rs.Lease_Charge__c).Type__c=='By Percent'){
                    if(parentRsMap.get(rs.parent_Rent_Schedule__c).Amount__c!=null && leaseChargeMap.get(rs.Lease_Charge__c).Charge_Rate__c!=null){
                        rs.Amount__c = -(parentRsMap.get(rs.parent_Rent_Schedule__c).Amount__c*leaseChargeMap.get(rs.Lease_Charge__c).Charge_Rate__c/100);
                        rs.Amount__c = rs.Amount__c.setScale(2);
                    }else{
                        rs.Amount__c = 0;
                    }
                }
            }
        }
    }*/
}