public class RelinkRentSchedulesController{
    public Electric_Meter__c elecMeter{get;set;}
    public Electric_Meter__c elecMtrUIDt{get;set;}
    public date startDate{get;set;}
    public date endDate{get;set;}
    public Boolean success{get;set;}
    public string oldMeterNo{get;set;}
    public Boolean isError{get;set;}
    public string errorMsg{get;set;}
    public RelinkRentSchedulesController(){
        isError = false;
        success = false;
        //startDate = system.today();
        
        elecMeter = new Electric_Meter__c();
        
        elecMtrUIDt = new Electric_Meter__c();
        elecMtrUIDt.Start_Date__c = system.today();
        
        for(Electric_Meter__c em:[Select id,Meter_No__c,Unit__c,Status__c,Meter_Type__c from Electric_Meter__c where id=:Apexpages.currentPage().getParameters().get('Id')]){
            elecMeter = em;
            oldMeterNo = em.Meter_No__c;
        }
    }
    
    public pageReference save(){
        isError = false;
        errorMsg = '';
        if(elecMeter.Status__c=='Active'){
        	
            if(elecMtrUIDt.Start_Date__c!=null && elecMtrUIDt.End_Date__c!=null){
            	startDate = elecMtrUIDt.Start_Date__c;
            	endDate = elecMtrUIDt.End_Date__c;
                if(startDate<endDate){
                    if(oldMeterNo!=elecMeter.Meter_No__c){
                        List<Rent_Schedules__c> rsList = [Select id,Electric_Meter_Number__c,(Select id from Electric_Transactions__r) from Rent_Schedules__c where Electric_Meter_Number__c like: ('%'+oldMeterNo+'%') and Status__c='In-Tenancy' and ((Start_Date__c>=:startDate and End_Date__c<=:endDate) or (End_Date__c>=:startDate and End_Date__c<=:endDate) or (Start_Date__c<:endDate and End_Date__c>:endDate))];
                        if(rslist.size()>0){
                            for(Rent_Schedules__c rs:rsList){
                                if(rs.Electric_Transactions__r.size()==0){
                                    rs.Electric_Meter_Number__c = rs.Electric_Meter_Number__c.replace(oldMeterNo,elecMeter.Meter_No__c);                                    
                                }
                            }
                            update rsList;
                        }else{
                            rsList = [Select id,Electric_Meter_Number__c,(Select id from Electric_Transactions__r) from Rent_Schedules__c where Charge_Type__c=:elecMeter.Meter_Type__c and  Status__c='In-Tenancy' and ((Start_Date__c>=:startDate and End_Date__c<=:endDate) or (End_Date__c>=:startDate and End_Date__c<=:endDate) or (Start_Date__c<:endDate and End_Date__c>:endDate))];
                            if(rslist.size()>0){
                                for(Rent_Schedules__c rs:rsList){
                                    if(rs.Electric_Transactions__r.size()==0){
                                        if(rs.Electric_Meter_Number__c!=null && rs.Electric_Meter_Number__c.trim().length()>0){
                                            rs.Electric_Meter_Number__c += ';'+elecMeter.Meter_No__c;
                                        }else{
                                            rs.Electric_Meter_Number__c = elecMeter.Meter_No__c;
                                        }
                                        rs.Electric_Meter_Number__c = rs.Electric_Meter_Number__c.replace(oldMeterNo,elecMeter.Meter_No__c);
                                    }
                                }
                                update rsList;
                            }                            
                        }
                        elecMeter.remarks__c = 'Meter No changed from '+oldMeterNo+' to '+elecMeter.Meter_No__c+ ' on '+system.today().day()+'/'+system.today().month()+'/'+system.today().Year();
                    }else{
                        List<Rent_Schedules__c> rsList = [Select id,Electric_Meter_Number__c,(Select id from Electric_Transactions__r) from Rent_Schedules__c where Charge_Type__c=:elecMeter.Meter_Type__c and Status__c='In-Tenancy' and ((Start_Date__c>=:startDate and End_Date__c<=:endDate) or (End_Date__c>=:startDate and End_Date__c<=:endDate) or (Start_Date__c<:endDate and End_Date__c>:endDate))];
                        if(rslist.size()>0){
                            for(Rent_Schedules__c rs:rsList){
                                if(rs.Electric_Transactions__r.size()==0){
                                    if(rs.Electric_Meter_Number__c!=null && rs.Electric_Meter_Number__c.trim().length()>0){
                                        if(!rs.Electric_Meter_Number__c.contains(elecMeter.Meter_No__c)){
                                            rs.Electric_Meter_Number__c += ';'+elecMeter.Meter_No__c;
                                        }
                                    }else{
                                        rs.Electric_Meter_Number__c = elecMeter.Meter_No__c;
                                    }
                                    rs.Electric_Meter_Number__c = rs.Electric_Meter_Number__c.replace(oldMeterNo,elecMeter.Meter_No__c);
                                }
                            }
                            update rsList;
                        }                            
                    }
                }else{
                    isError = true;
                    errorMsg = 'End Date should be greater than Start Date.';
                    return null;
                }
            }else{
                isError = true;
                errorMsg = 'Please enter Start and End Date.';
                return null;
            }
        }else{
            if(oldMeterNo!=elecMeter.Meter_No__c){
                isError = true;
                errorMsg = 'You cannot change Meter No while its Inactive.';
                return null;
            }
            List<Rent_Schedules__c> deleteRsList = new List<Rent_Schedules__c>();
            List<Rent_Schedules__c> updateRsList = new List<Rent_Schedules__c>();
            List<Rent_Schedules__c> rsList = [Select id,Electric_Meter_Number__c,Status__c,(Select id from Electric_Transactions__r) from Rent_Schedules__c where Electric_Meter_Number__c like: ('%'+elecMeter.Meter_No__c+'%') and Status__c='In-Tenancy'];
            if(rsList.size()>0){
                for(Rent_Schedules__c rs:rsList){
                    if(rs.Electric_Transactions__r.size()==0){
                        if(rs.Electric_Meter_Number__c.contains(elecMeter.Meter_No__c+';')){
                            rs.Electric_Meter_Number__c = rs.Electric_Meter_Number__c.replace(elecMeter.Meter_No__c+';','');
                            updateRsList.add(rs);
                        }else if(rs.Electric_Meter_Number__c.contains(';'+elecMeter.Meter_No__c)){
                            rs.Electric_Meter_Number__c = rs.Electric_Meter_Number__c.replace(';'+elecMeter.Meter_No__c,'');
                            updateRsList.add(rs);
                        }else if(rs.Electric_Meter_Number__c==elecMeter.Meter_No__c){
                            deleteRsList.add(rs);
                        }
                    }
                }
                if(updateRsList.size()>0){
                    update updateRsList;
                }
                if(deleteRsList.size()>0){
                    delete deleteRsList;
                }
            }
        }
        update elecMeter;
        success = true;
        return null;
    }
}