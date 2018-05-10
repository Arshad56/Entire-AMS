/*
*   Developer Name: Arshad Shaikh
*   Date Created: Jan 21 2017       Last updated : Oct-16-2017
*   Description: Trigger on Rent Schedule that calls Cal No Of Prorated Days, Amount Calculation By Lease or Lease unit
*/
trigger calPercentage on Rent_Schedules__c(before insert, before update, after insert, after update) {
    /*if( Utility.doGTO ){
        System.debug('111 --> '+ Utility.doGTO );
        set<Id> leaseIds = new set<Id>();
        set<Id> unitIds = new set<Id>();
        set<Id> leaseUnitIds = new set<Id>();
        set<Id> gtoByLeaseIds = new set<Id>(); 
        set<Id> rsIds = new set<Id>(); 
        for (Rent_Schedules__c rs: Trigger.new) {
            leaseIds.add(rs.Lease_Charge__c);
            leaseIds.add(rs.Base_Rent_RS_1__c);
            leaseIds.add(rs.Base_Rent_RS_2__c); 
            if (rs.Unit__c != null) {
                unitIds.add(rs.Unit__c);
            }
            if (rs.Lease_Unit__c != null) {
                leaseUnitIds.add(rs.Lease_Unit__c);
            }
        }
        Map<Id, Lease_Unit__c>luMap = new map<Id, Lease_Unit__c>([select Id, Lease_Agreement_No__c, Lease_Agreement_No__r.GTO_Billed__c,(select Id, Charge_Rate__c, Base_Rent_Calculation__c, Billing_Terms__c, Billing_Frequency__c, End_Date__c, Charge_Type__c, Type__c from Lease_Charges__r) from Lease_Unit__c where id =: leaseUnitIds]);
        Map<Id, Lease_Charges__c>leaseMap = new Map<Id, Lease_Charges__c>();//[select Id, Charge_Rate__c, Base_Rent_Calculation__c, Billing_Terms__c, Billing_Frequency__c, End_Date__c, Charge_Type__c, Type__c from Lease_Charges__c where Id In: leaseIds]);
        for(Lease_Unit__c luu:luMap.values()){
            for(Lease_Charges__c lcc:luu.Lease_Charges__r){
                leaseMap.put(lcc.Id,lcc);
            }
        }
        Map<Id, Units__c>unitMap = new Map<Id, Units__c>([select Id, Charge_Method__c, NLA_SQF__c from Units__c where id =: unitIds]);
        Decimal tempPercent;
        for (Rent_Schedules__c rs: Trigger.new) {
            //tempPercent = 0.00;
            System.debug('Inside For --> '+ Utility.doGTO );
            if (Trigger.isBefore) {
                System.debug('In Before --> '+ Utility.doGTO );
                System.debug('leaseMap.containsKey(rs.Lease_Charge__c) ' + leaseMap.containsKey(rs.Lease_Charge__c));
                if (rs.Lease_Charge__c != null && leaseMap.containsKey(rs.Lease_Charge__c)) {
                    Boolean checkRate = false;
                    if (unitMap.containskey(rs.Unit__c) && unitMap.get(rs.Unit__c).Charge_Method__c != null) {
                        if (unitMap.get(rs.Unit__c).Charge_Method__c.contains('Daily Rate') && leaseMap.get(rs.Lease_Charge__c).Charge_Type__c != null)
                            checkRate = true;
                    }
                    System.debug('leaseMap.get(rs.Lease_Charge__c)-->' + checkRate);
                    System.debug('leaseMap.get(rs.Lease_Charge__c).Charge_Type__c-->' + leaseMap.get(rs.Lease_Charge__c).Charge_Type__c);
                    Boolean checkMeterUnit = (leaseMap.get(rs.Lease_Charge__c).Billing_Terms__c == 'Non-prorate' && leaseMap.get(rs.Lease_Charge__c).Billing_Frequency__c != 'Monthly')?true:false;
                    System.debug(checkMeterUnit+' 11111-->' + leaseMap.get(rs.Lease_Charge__c).Billing_Terms__c + ' '+leaseMap.get(rs.Lease_Charge__c).Billing_Frequency__c);
                    if(leaseMap.get(rs.Lease_Charge__c).Type__c == 'Meter Units' || checkRate){
                        tempPercent = 1.0 * 100;
                    }else if (checkRate && !checkMeterUnit && (leaseMap.get(rs.Lease_Charge__c).Charge_Type__c == 'Advance Rental' || leaseMap.get(rs.Lease_Charge__c).Charge_Type__c == 'Rent')) {
                        tempPercent = 1.0 * 100;
                    } else if ((leaseMap.get(rs.Lease_Charge__c).Billing_Terms__c == 'Non-prorate' || checkMeterUnit) && rs.End_Date__c.day() == (rs.Start_Date__c.day() - 1) && rs.Start_Date__c.month() != rs.End_Date__c.month()) {
                        tempPercent = 1.0 * 100;
                    } else if ((leaseMap.get(rs.Lease_Charge__c).Billing_Terms__c == 'Non-prorate' || checkMeterUnit) && rs.End_Date__c.day() < (rs.Start_Date__c.day() - 1) && rs.Start_Date__c.month() != rs.End_Date__c.month()) {
                        System.debug('1111111');
                        if (rs.Start_Date__c.month() == 2 && rs.Leap_Year__c) {
                            tempPercent = ((29 - rs.Start_Date__c.day()) + 1) * 100 / 29.0;
                        } else {
                            if (rs.Start_Date__c.month() == 2 && !rs.Leap_Year__c) {
                                tempPercent = ((28 - rs.Start_Date__c.day()) + 1) * 100 / 28.0;
                            } else {
                                if (rs.Start_Date__c.month() == 1 || rs.Start_Date__c.month() == 3 || rs.Start_Date__c.month() == 5 || rs.Start_Date__c.month() == 7 || rs.Start_Date__c.month() == 12 || rs.Start_Date__c.month() == 8 || rs.Start_Date__c.month() == 10) {
                                    tempPercent = ((31 - rs.Start_Date__c.day()) + 1) * 100 / 31.0;
                                    System.debug('inside Condition ');
                                } else {
                                    if (rs.Start_Date__c.month() == 4 || rs.Start_Date__c.month() == 6 || rs.Start_Date__c.month() == 11 || rs.Start_Date__c.month() == 9) {
                                        tempPercent = ((30 - rs.Start_Date__c.day()) + 1) * 100 / 30.0;
                                    } else {
                                        tempPercent = 1.0 * 100;
                                    }
                                }
                            }
                        }
    
                        System.debug('tempPercent11 ' + tempPercent);
                        if (rs.End_Date__c.month() == 2 && rs.Leap_Year__c) {
                            tempPercent += rs.End_Date__c.day() * 100 / 29.0;
                        } else {
                            if (rs.End_Date__c.month() == 2 && !rs.Leap_Year__c) {
                                tempPercent += rs.End_Date__c.day() * 100 / 28.0;
                            } else {
                                if (rs.End_Date__c.month() == 1 || rs.End_Date__c.month() == 3 || rs.End_Date__c.month() == 5 || rs.End_Date__c.month() == 7 || rs.End_Date__c.month() == 12 || rs.End_Date__c.month() == 8 || rs.End_Date__c.month() == 10) {
                                    tempPercent += rs.End_Date__c.day() * 100 / 31.0;
                                } else {
                                    if (rs.End_Date__c.month() == 4 || rs.End_Date__c.month() == 6 || rs.End_Date__c.month() == 11 || rs.End_Date__c.month() == 9) {
                                        tempPercent += rs.End_Date__c.day() * 100 / 30.0;
                                    } else {
                                        tempPercent += 1.0 * 100;
                                    }
                                }
                            }
                        }
                    } else {
                        System.debug('22222');
    
                        //Date strtDT = rs.Start_Date__c.month() != rs.End_Date__c.month()
                        if (((leaseMap.get(rs.Lease_Charge__c).Charge_Type__c == 'Advance Rental' && leaseMap.get(rs.Lease_Charge__c).Billing_Frequency__c != 'Monthly') ||
                            leaseMap.get(rs.Lease_Charge__c).Type__c == 'Meter Units') && !checkMeterUnit) {
                            tempPercent = 1.0 * 100;
                        } else {
                            if (rs.Start_Date__c.month() == 2 && rs.Leap_Year__c) {
                                tempPercent = ((rs.End_Date__c.day() - rs.Start_Date__c.day()) + 1) * 100 / 29.0;
                            } else {
                                if (rs.Start_Date__c.month() == 2 && !rs.Leap_Year__c) {
                                    tempPercent = ((rs.End_Date__c.day() - rs.Start_Date__c.day()) + 1) * 100 / 28.0;
                                } else {
                                    if (rs.Start_Date__c.month() == 1 || rs.Start_Date__c.month() == 3 || rs.Start_Date__c.month() == 5 || rs.Start_Date__c.month() == 7 || rs.Start_Date__c.month() == 12 || rs.Start_Date__c.month() == 8 || rs.Start_Date__c.month() == 10) {
                                        tempPercent = ((rs.End_Date__c.day() - rs.Start_Date__c.day()) + 1) * 100 / 31.0;
                                    } else {
                                        if (rs.Start_Date__c.month() == 4 || rs.Start_Date__c.month() == 6 || rs.Start_Date__c.month() == 11 || rs.Start_Date__c.month() == 9) {
                                            tempPercent = ((rs.End_Date__c.day() - rs.Start_Date__c.day()) + 1) * 100 / 30.0;
                                        } else {
                                            tempPercent = 1.0 * 100;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    rs.Calc_No_of_Days_Pro_Rated_2__c = tempPercent.SetScale(2);
                    System.debug(rs.Calc_No_of_Days_Pro_Rated_2__c+ ' after value asign --> '+ Utility.doGTO );
                    if (luMap.containsKey(rs.Lease_Unit__c)) {
                        if (luMap.get(rs.Lease_Unit__c).Lease_Agreement_No__r.GTO_Billed__c == 'By Lease Unit') {
                            if (!rs.Tiered__c && rs.GTO_Monthly_Total_Converted__c != null && leaseMap.get(rs.Lease_Charge__c).Charge_Rate__c != null) {
                                rs.GTO_Amount1__c = rs.GTO_Monthly_Total_Converted__c * leaseMap.get(rs.Lease_Charge__c).Charge_Rate__c / 100.00;
                            } else {
                                if (rs.Cumulative__c) {
                                    rs.GTO_Amount1__c = rs.Calc_Cumulative_Tiered__c;
                                } else {
                                    rs.GTO_Amount1__c = rs.Calc_NonCumulative_Tiered__c;
                                }
                            }
                            System.debug('rs.GTO_Amount1__c->' + rs.GTO_Amount1__c);
                            if (rs.GTO_Amount1__c == null) {
                                rs.GTO_Amount1__c = 0;
                            }
                            decimal grossRent = 0;
                            decimal grossRentCap = 0;
                            decimal baseRentcal = 0;
                            decimal capValue = 0;
                            if (rs.Cap_Value__c == null) {
                                capValue = 0;
                            } else {
                                capValue = rs.Cap_Value__c;
                            }
                            if (rs.Converted_Base_Rent__c == null) {
                                baseRentcal = 0;
                            } else {
                                baseRentcal = rs.Converted_Base_Rent__c;
                            }
    
    
                            if (leaseMap.get(rs.Lease_Charge__c).Type__c == 'GTO (Sum)') {
    
                                grossRent = rs.GTO_Amount1__c + baseRentcal;
                                System.debug('grossRent->' + grossRent);
                            } else {
                                if (leaseMap.get(rs.Lease_Charge__c).Type__c == 'GTO (Higher)') {
                                    if (rs.GTO_Amount1__c>baseRentcal) {
                                        grossRent = rs.GTO_Amount1__c;
                                    } else {
                                        grossRent = baseRentcal;
                                    }
                                } else {
                                    if (leaseMap.get(rs.Lease_Charge__c).Type__c == 'GTO') {
                                        grossRent = rs.GTO_Amount1__c;
                                    } else {
                                        grossRent = 0;
                                    }
                                }
                            }
                            System.debug('grossRent-->' + grossRent);
                            if (rs.Unit__c != null && unitMap.containsKey(rs.Unit__c)) {
                                if (unitMap.get(rs.Unit__c).NLA_SQF__c == null) {
                                    unitMap.get(rs.Unit__c).NLA_SQF__c = 0;
                                }
                                if (grossRent <= (capValue * rs.Calc_No_of_Days_Pro_Rated_2__c * unitMap.get(rs.Unit__c).NLA_SQF__c) / 100 || capValue * unitMap.get(rs.Unit__c).NLA_SQF__c <= 0) {
                                    grossRentCap = grossRent;
                                } else {
                                    grossRentCap = capValue * rs.Calc_No_of_Days_Pro_Rated_2__c * unitMap.get(rs.Unit__c).NLA_SQF__c / 100;
                                } 
                            }
                            System.debug('rs.Lease_Charge__c-->' + rs.Lease_Charge__c);
                            if (rs.Lease_Charge__c != null) {
                                if (leaseMap.get(rs.Lease_Charge__c).Type__c == 'GTO (Higher)' || leaseMap.get(rs.Lease_Charge__c).Type__c == 'GTO (Sum)') {
                                    System.debug('Sum Higher case');
                                    System.debug('grossRentCap-->' + grossRentCap);
                                    System.debug('baseRentcal-->' + baseRentcal);
                                    System.debug('rs.Calc_No_of_Days_Pro_Rated_2__c-->' + rs.Calc_No_of_Days_Pro_Rated_2__c);
                                    System.debug('*****-->' + baseRentcal);
                                    if (grossRentCap >= baseRentcal) {
                                        rs.Calculated_Amount_Higher_or_Sum__c = grossRentCap - baseRentcal;
                                    } else {
                                        rs.Calculated_Amount_Higher_or_Sum__c = 0;
                                    }
                                } else if (leaseMap.get(rs.Lease_Charge__c).Type__c == 'GTO') {
                                    rs.Calculated_Amount_Higher_or_Sum__c = grossRentCap;
                                }
                            }
                        }
                    }
    
                } 
               // Utility.doGTO = true;
            }
            if(Trigger.isAfter){
                if(!Test.isRunningTest()){
                    //Utility.doGTO = false;
                }
                System.debug(Utility.doGTO+' Trigger.isAfter-->'+Trigger.isAfter);
                if (Trigger.isAfter && luMap.containsKey(rs.Lease_Unit__c) && rs.Lease_Unit__c != null) {
                    if (luMap.get(rs.Lease_Unit__c).Lease_Agreement_No__r.GTO_Billed__c == 'By Lease (Lease Unit)' || luMap.get(rs.Lease_Unit__c).Lease_Agreement_No__r.GTO_Billed__c == 'By Lease (Summary)') {
                        System.debug('rs.Id-->'+rs.Id);
                        gtoByLeaseIds.add(luMap.get(rs.Lease_Unit__c).Lease_Agreement_No__c);
                        rsIds.add(rs.Id);
                    }
                }
            }
        } 
        if(Trigger.isAfter && gtoByLeaseIds.size() > 0 && !Test.isRunningTest()){
            System.debug('<--Utility.doGTO-->'+Utility.doGTO);
            System.debug('<--Calling GTO cal BY Lease-->');
            CalPercentage_ByLease_Helper.doGTOcalculation(gtoByLeaseIds, rsIds);
            
            System.debug('<--Utility.doGTO-->'+Utility.doGTO);
        }
    }*/
}