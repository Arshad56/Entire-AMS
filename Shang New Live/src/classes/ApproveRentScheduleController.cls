public class ApproveRentScheduleController{
    /*public Rent_Roll__c rentRoll{get;set;}
    public List<Rent_Roll__c> rentRollList{get;set;}
    public string status{get;set;}
    public string selRentRollId{get;set;}
    public Boolean showRentDetail{get;set;}
    public Boolean selectAll{get;set;}
    public List<Rent_Schedules__c> rentScheduleList{get;set;}
    
    public List<Rent_Roll__c> displayRentRolLList{get;set;}
    public Boolean isrrNext{get;set;}
    public Boolean isrrPrev{get;set;}
    public Integer rrPageSize{get;set;}
    public Integer rrRecordCount{get;set;}
    public ApproveRentScheduleController(){
        rrPageSize = 10;
        isrrPrev = false;
        isrrNext = false;
        rrRecordCount = 0;
        displayRentRolLList = new List<Rent_Roll__c>();
        
        rentRoll = new Rent_Roll__c();
        rentRollList = new List<Rent_Roll__c>();        
        status = 'Approved';
        showRentDetail = false;
        selectAll = false;
        rentScheduleList = new List<Rent_Schedules__c>();
    }
    
    public void search(){
        rentRollList = new List<Rent_Roll__c>();
        displayRentRolLList = new List<Rent_Roll__c>();
        if(rentRoll.Property__c!=null){
            string query = 'Select id,Name,Property_Name__c,Rent_Roll_Date__c,Approved__c,Property__c,Approver__c,Total_Diesel_Rate__c,Total_Leased_Area_Sq_Ft__c,(Select id,Name,Active__c,Billing_Date__c,End_Date__c,Expected_Amount__c,Hold__c,Lease_Unit__c,Rent_Roll__c,Start_Date__c,Status__c,Total_Units_p__c,Trading_Day_s__c,Unit__c,Approved__c,Tenant__c,Unit__r.Name,Lease_Charge__r.Name,Total_Units__c,Lease_Charge__r.Charge_Rate__c,Amount__c,Lease_Charge__c,Lease_Unit__r.Lease_Agreement_No__c,Lease_Charge__r.Charge_Description__c from Rent_Schedules__r where Approved__c=false) from Rent_Roll__c where Property__c=\''+rentRoll.Property__c+'\'';
            if(status=='Approved'){            
                query += ' and Approved__c=true';
            }else if(Status=='Pending Approval'){
                query += ' and Approved__c=false';
            }
            
            query += ' limit 1000';
            
            for(Rent_Roll__c rr:database.query(query)){
                if(rr.Rent_Schedules__r.size()>0){
                    rentRollList.add(rr);
                }
            }
            
            if(rentRollList.size()>rrPageSize){
                isrrNext = true;
                for(Integer i=0;i<rrPageSize;i++){
                    displayrentRollList.add(rentRollList[i]);
                }
                rrRecordCount = rrPageSize;
            }else{
                displayrentRollList = rentRollList;
            }
        }
    }
    
    public void rrNext(){
        displayRentRolLList = new List<Rent_Roll__c>();
        Integer maxCount = rrRecordCount + rrPageSize;
        if(maxCount>rentRollList.size()){
            maxCount = rentRollList.size();
        }
        for(Integer i=rrRecordCount;i<maxcount;i++){
            displayRentRollList.add(rentRollList[i]);
        }
        rrRecordCount = maxCount;
        isrrPrev= true;
        if(rrRecordCount==rentRollList.size()){
            isrrNext = false;
        }
        
    }
    
    public void rrPrevious(){
        displayRentRolLList = new List<Rent_Roll__c>();
        if(rrRecordCount==rentRollList.size()){
            rrRecordCount = rrRecordCount - (Math.mod(rrRecordCount,rrPageSize)>0?Math.mod(rrRecordCount,rrPageSize):rrPageSize);
        }else{
            rrRecordCount = rrRecordCount - rrPageSize;
        }
        Integer minCount = rrRecordCount - rrPageSize;
        for(Integer i=rrRecordCount-1;i>=mincount;i--){
            displayRentRollList.add(rentRollList[i]);
        }
        isrrNext = true;
        if(rrRecordCount==rrPageSize){
            isrrPrev = false;
        }
    }
    
    public void selectRentRoll(){
        rentScheduleList = new List<Rent_Schedules__c>();
        if(selRentRollId!=null){
            for(rent_Roll__c rr:rentRollList){
                if(rr.Id==selRentRollId){
                    rentRoll = rr;
                    showRentDetail = true;
                    rentScheduleList = rr.Rent_Schedules__r;
                    break;
                }
            }
        }
    }
    
    public void selectAllToApprove(){
        for(Rent_Schedules__c rs:rentScheduleList){
            rs.Approved__c = selectAll;
        }
    }
    
    public pageReference approve(){
        if(rentRoll.Id!=null){
            if(rentScheduleList.size()>0){
                Boolean apprCheck = false;
                List<Rent_Roll_Detail__c> rrDetailList = new List<Rent_Roll_Detail__c>();
                for(Rent_Schedules__c rs:rentScheduleList){
                    if(rs.Approved__c){
                        apprCheck = true;
                        
                        Rent_Roll_Detail__c rrDet = new Rent_Roll_Detail__c();
                        rrDet.Name = rs.Name;
                        rrDet.Active__c = rs.Active__c;
                        rrDet.Amount__c = rs.Amount__c;
                        rrDet.Approved__c = rs.Approved__c;
                        rrDet.Billing_Date__c = rs.Billing_Date__c;
                        rrDet.End_Date__c = rs.End_Date__c;
                        rrDet.Lease_Charge__c = rs.Lease_Charge__c;
                        rrDet.Lease_Unit__c = rs.Lease_Unit__c;
                        rrDet.Rent_Roll__c = rs.Rent_Roll__c;
                        rrDet.Start_Date__c = rs.Start_Date__c;
                        rrDet.Status__c = rs.Status__c;
                        rrDet.Total_Units_p__c = rs.Total_Units_p__c;
                        rrDet.Trading_Day_s__c = rs.Trading_Day_s__c;
                        rrDet.Unit__c = rs.Unit__c;
                        rrDetailList.add(rrDet);
                    }
                }
                if(!apprCheck){
                    Apexpages.addMessage(new apexpages.message(Apexpages.Severity.Error,'Please check atleast 1 Rent Schedule.'));
                    return null;
                }
                update rentScheduleList;
                insert rrDetailList;
                
                Invoice__c inv = new Invoice__c();
                inv.Rent_Roll__c = rentRoll.Id;
                inv.Status__c = 'Ready';
                inv.Invoice_Date__c = rentRoll.Rent_Roll_Date__c;
                if(rentRoll.Rent_Roll_Date__c!=null){
                    inv.Payment_Due_Date__c = rentRoll.Rent_Roll_Date__c.addMonths(1);
                }
                inv.Invoice_Type__c = 'System Generated Invoice';
                inv.Name = 'INV-'+rentRoll.Property_Name__c+'-'+rentScheduleList[0].Tenant__c+'-'+rentRoll.Rent_Roll_Date__c.format(); 
                inv.Lease__c = rentScheduleList[0].Lease_Unit__r.Lease_Agreement_No__c;
                insert inv;
                List<Invoice_Line_Item__c> lineItmList = new List<Invoice_Line_Item__c>();
                for(Rent_Schedules__c rs:rentScheduleList){
                    if(rs.Approved__c){
                        Invoice_Line_Item__c invLinItm = new Invoice_Line_Item__c();
                        invLinItm.Rent_Schedule__c = rs.Id;
                        invLinItm.Description__c = rs.Lease_Charge__r.Charge_Description__c;
                        invLinItm.Amount__c = rs.Amount__c;
                        invLinItm.Invoice__c = inv.Id;
                        lineItmList.add(invLinItm);
                    }
                }
                insert lineItmList;
                return new pageReference('/'+inv.Id);
            }else{
                Apexpages.addMessage(new apexpages.message(Apexpages.Severity.Error,'Rent Schedules not found.'));
            }
        }else{
            Apexpages.addMessage(new apexpages.message(Apexpages.Severity.Error,'Rent Roll not found.'));
        }
        return null;
    }
    
    public void save(){
        update rentRoll;
        rentScheduleList = [Select id,Approved__c,Tenant__c,Unit__r.Name,Lease_Charge__r.Name,Total_Units__c,Lease_Charge__r.Charge_Rate__c,Amount__c,Lease_Charge__c,Lease_Unit__r.Lease_Agreement_No__c,Lease_Charge__r.Charge_Description__c from Rent_Schedules__c where Rent_Roll__c=:rentRoll.Id and Approved__c=false];
    }*/
}