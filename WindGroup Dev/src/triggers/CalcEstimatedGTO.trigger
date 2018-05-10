/*
*   Developer Name: Nicholas See
*   Email: nicholas.see@wind.com.sg/nicholassee8@gmail.com
*   Date: Aug-4-2017
*   Description: Trigger on Rent Schedule that calls Estimated GTO to compute estimated gto billing
*   for rent schedules that are of GTO Rent Charge Type only.
*/

trigger CalcEstimatedGTO on Rent_Schedules__c (after insert, after update, before insert, before update) {
/*
    // constant variables for GTO Billed field in Lease__c
    private static final String GTOBYLEASEUNIT = 'By Lease Unit';
    private static final String GTOBYLEASELEASEUNIT = 'By Lease (Lease Unit)';
    private static final String GTOBYLEASESUMMARY = 'By Lease (Summary)';
    
    // Constant variables for Charge Type field in Rent_Schedules__c
    private static final String GTOCHARGETYPE = 'GTO Rent';
    
    // Constant variables for Type field in Lease_Charge__c
    private static final String GTOHIGHERTYPE = 'GTO (Higher)';
    private static final String GTOTYPE = 'GTO';
    private static final String GTOSUMTYPE = 'GTO (Sum)';

    Map<Id, Rent_Schedules__c> rsFrmTrigger = new Map<Id, Rent_Schedules__c>();
    private Decimal proratedDays;
    
    Date startDate = system.today();
    Date endDate = system.today();
    
    Set<Id> leaseIds = new Set<Id>();
    
    Map<Id, List<Rent_Schedules__c>> gtoRsByLease = new Map<Id, List<Rent_Schedules__c>>();
    
    // Store RS only if Charge Type is GTO Rent
    for(Rent_Schedules__c rs: Trigger.new){
        // check if est gto amount has any changes to prevent recursive trigger
        if (rs.Id!=null && rs.Charge_Type__c!= null && rs.Charge_Type__c.equals(GTOCHARGETYPE)){
            rsFrmTrigger.put(rs.Id, rs);

            if(rs.Start_Date__c < startDate){
                startDate = rs.Start_Date__c;
            }
            if(rs.End_Date__c > endDate){
                endDate = rs.End_Date__c;
            }
        }
    }
    // Proceed with logic if map of RS has any GTO Rent Type
    if(rsFrmTrigger.size()>0){
        // Query to retrieve  lease agreement and lease charge terms of RS based on lookup relationships
        Map<Id, Rent_Schedules__c> gtoRS = new Map<Id, Rent_Schedules__c>([SELECT Id, Start_Date__c, End_Date__c, Currency_Code__c, Estimated_GTO_Rent__c, Estimated_GTO_Amount__c, Lease_Charge__r.Id, Lease_Unit__r.Id, 
        Lease_Unit__r.Lease_Agreement_No__r.Id, Lease_Unit__r.Lease_Agreement_No__r.Name, Lease_Unit__r.Lease_Agreement_No__r.GTO_Billed__c,
        Lease_Charge__r.Charge_Rate__c, Lease_Charge__r.Type__c, Lease_Charge__r.Billing_Terms__c, Lease_Charge__r.Billing_Frequency__c,
        Lease_Charge__r.End_Date__c, Lease_Charge__r.Charge_Type__c, Unit__r.Id, Unit__r.Charge_Method__c, Unit__r.NLA_SQF__c 
        FROM Rent_Schedules__c WHERE Id IN : rsFrmTrigger.keySet()]);
        Decimal tempPercent;
        
        if(Trigger.isBefore){
            EstimatedGTO estGTO = new EstimatedGTO(true, rsFrmTrigger, gtoRS, gtoRsByLease, leaseIds, startDate, endDate);
        }
        else if(Trigger.isAfter){
            
            for(Rent_Schedules__c indivGtoRs: gtoRS.values()){
                leaseIds.add(indivGtoRs.Lease_Unit__r.Lease_Agreement_No__r.Id);
            }
            // Retrieve gto rs under the same lease with Charge Type 'GTO Rent' and RS period must be within triggered rs's start and end date
            Map<Id, Rent_Schedules__c> leaseRelatedGtoRs = new Map<Id, Rent_Schedules__c>([Select Id,Tiered__c,Transaction_Status__c, Estimated_GTO_Rent__c, Estimated_GTO_Amount__c, Est_Calc_Non_Cumulative_Tiered__c, 
            Est_Calc_Cumulative_Tiered__c, Cap_Value__c, Leap_Year__c, Unit__r.NLA_SQF__c, Cap_Amount__c,GTO_Rent_By_Lease__c,Cumulative__c,Currency_Code__c,
            Start_Date__c, End_Date__c, Lease_Unit__r.Id, Lease_Unit__r.Lease_Agreement_No__r.GTO_Billed__c, Lease_Unit__r.Lease_Agreement_No__r.Id, Lease_Charge__r.Charge_Rate__c 
            FROM Rent_Schedules__c 
            WHERE Charge_Type__c = : GTOCHARGETYPE
            AND Start_Date__c <= : endDate
            AND End_Date__c >= : startDate
            AND Lease_Unit__r.Lease_Agreement_No__r.Id IN : leaseIds]);
            
            System.debug('Related Rs : ' + leaseRelatedGtoRs);
            // group gto rs by lease id and store in gtoRsByLease
            for(Rent_Schedules__c luRelatedGtoRs : leaseRelatedGtoRs.values()){
                if(gtoRsByLease.containsKey(luRelatedGtoRs.Lease_Unit__r.Lease_Agreement_No__r.Id)){
                    List<Rent_Schedules__c> tempRSList = gtoRsByLease.get(luRelatedGtoRs.Lease_Unit__r.Lease_Agreement_No__r.Id);
                    tempRSList.add(luRelatedGtoRs);
                    gtoRsByLease.put(luRelatedGtoRs.Lease_Unit__r.Lease_Agreement_No__r.Id, tempRSList);
                }else{
                    gtoRsByLease.put(luRelatedGtoRs.Lease_Unit__r.Lease_Agreement_No__r.Id, new List<Rent_Schedules__c> {luRelatedGtoRs});
                }
            }
            EstimatedGTO estGTO = new EstimatedGTO(false, rsFrmTrigger, gtoRS, gtoRsByLease, leaseIds, startDate, endDate);
        }
    }
    */
}