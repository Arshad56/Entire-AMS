trigger CalcChildBaseRent on Rent_Schedules__c (after update) {
    /*Set<Id> rsIds = new Set<Id>();
    for(Rent_Schedules__c rs:Trigger.New){
        if(rs.Amount__c!=Trigger.OldMap.get(rs.Id).Amount__c || rs.Exchange_Rate__c!=Trigger.Oldmap.get(rs.Id).Exchange_Rate__c){
            rsIds.add(rs.Id);
        }
    }
    if(rsIds.size()>0){
        List<Rent_Schedules__c> childRsList = [Select id,Start_Date__c,End_Date__c,Base_Rent_RS_1__c,Base_Rent_RS_2__c,Currency_Code__c from Rent_Schedules__c where Base_Rent_RS_1__c in:rsIds or Base_Rent_RS_2__c in:rsIds];
        Set<Id> parentRsIds = new Set<Id>();
        for(Rent_Schedules__c rs:childRsList){
            if(rs.Base_Rent_RS_1__c!=null){
                parentRsIds.add(rs.Base_Rent_RS_1__c);
            }
            
            if(rs.Base_Rent_RS_2__c!=null){
                parentRsIds.add(rs.Base_Rent_RS_2__c);
            }
        }
        
        Map<Id,Rent_Schedules__c> baseRentRsMap = new Map<Id,Rent_Schedules__c>([Select id,Start_Date__c,End_Date__c,Amount__c,Amount_Local__c,Amount_Foreign__c from Rent_Schedules__c where id in:parentRsIds]);
        
        for(Rent_Schedules__c rs:childRsList){
            if(rs.Base_Rent_RS_1__c!=null && rs.Base_Rent_RS_2__c==null){
                if(baseRentRsMap.containsKey(rs.Base_Rent_RS_1__c)){
                    Integer daysGap = rs.Start_Date__c.daysBetween(rs.End_Date__c)+1;
                    Integer daysInMonth = Date.DaysInMonth(rs.Start_Date__c.Year(),rs.Start_Date__c.Month());
                    decimal proRateDays = 1.00*daysGap/daysInMonth;
                    proRateDays = proRateDays.setScale(4);
                    if(rs.Currency_Code__c!=label.Default_Currency){                    
                        if(baseRentRsMap.get(rs.Base_Rent_RS_1__c).Amount_Foreign__c!=null){
                            rs.Converted_Base_Rent__c = proRateDays*(baseRentRsMap.get(rs.Base_Rent_RS_1__c).Amount_Foreign__c);
                        } 
                    }else{
                        if(baseRentRsMap.get(rs.Base_Rent_RS_1__c).Amount_Local__c!=null){
                            rs.Converted_Base_Rent__c = proRateDays*(baseRentRsMap.get(rs.Base_Rent_RS_1__c).Amount_Local__c);
                        }
                    }
                }
            }else if(rs.Base_Rent_RS_1__c!=null && rs.Base_Rent_RS_2__c!=null){
                if(baseRentRsMap.containsKey(rs.Base_Rent_RS_1__c) && baseRentRsMap.containsKey(rs.Base_Rent_RS_2__c)){
                    decimal amount1 = 0;
                    decimal amount2 = 0;
                    decimal proRateDays1 = 1.00*(rs.Start_Date__c.daysBetween(baseRentRsMap.get(rs.Base_Rent_RS_1__c).End_Date__c) + 1)/Date.DaysInMonth(rs.Start_Date__c.year(),rs.Start_Date__c.Month());
                    proRateDays1 = proRateDays1.setScale(4);
                    decimal proRateDays2 = 1.00*(baseRentRsMap.get(rs.Base_Rent_RS_2__c).Start_Date__c.DaysBetween(rs.End_Date__c)+1)/Date.DaysInMonth(rs.Start_Date__c.year(),rs.Start_Date__c.Month());
                    proRateDays2 = proRateDays2.setScale(4);
                    if(rs.Currency_Code__c!=label.Default_Currency){
                        if(baseRentRsMap.get(rs.Base_Rent_RS_1__c).Amount_Foreign__c!=null){
                            amount1 = proRateDays1*baseRentRsMap.get(rs.Base_Rent_RS_1__c).Amount_Foreign__c;
                        }
                        if(baseRentRsMap.get(rs.Base_Rent_RS_2__c).Amount_Foreign__c!=null){
                            amount2 = proRateDays2*baseRentRsMap.get(rs.Base_Rent_RS_2__c).Amount_Foreign__c;
                        }

                    }else{
                        if(baseRentRsMap.get(rs.Base_Rent_RS_1__c).Amount_Local__c!=null){
                            amount1 = proRateDays1*baseRentRsMap.get(rs.Base_Rent_RS_1__c).Amount_Local__c;
                        }
                        if(baseRentRsMap.get(rs.Base_Rent_RS_2__c).Amount_Local__c!=null){
                            amount2 = proRateDays2*baseRentRsMap.get(rs.Base_Rent_RS_2__c).Amount_Local__c;
                        }
                    }
                    rs.Converted_Base_Rent__c = amount1 + amount2;
                }
            }
        }
        update childRsList;
    }*/
}