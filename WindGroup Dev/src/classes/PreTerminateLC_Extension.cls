public  class PreTerminateLC_Extension {
	public Lease_Charges__c leaseCharge{get;set;}
    public String selectedLeaseCharge{get;set;}
    public Boolean closePage{get;set;}
	public Boolean error{get;set;}
    public Boolean termError{get;set;}
    public String dtString{get;set;}
    String currentEndDate{get;set;}
    Date EndDate{get;set;}
    public Boolean erroOnLoad{get;set;}
    public PreTerminateLC_Extension(ApexPages.StandardController stdController) {
        this.leaseCharge = (Lease_Charges__c)stdController.getRecord();
        selectedLeaseCharge =  ApexPages.currentpage().getParameters().get('selectedLeaseCharges');
        currentEndDate =   ApexPages.currentpage().getParameters().get('endDate'); 
        
        leaseCharge.End_Date__c = date.parse(currentEndDate);
        
        
        list<Lease_Charges__c> discLClist = [select Id,Parent_Lease_Charge__c,Pre_Termination__c from Lease_Charges__c where Parent_Lease_Charge__c =: selectedLeaseCharge And Pre_Termination__c = false];
        System.debug('discLClist-->'+discLClist);
        if(discLClist.size()>0){
        	erroOnLoad =true;
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Terminate dependent Lease Charge and related Rent Schedule(s) before you proceed.')); 
        }
    }
    public void  checkDate() {
    	SavePoint sp = Database.setSavePoint();
		error = false;
		
		Lease_Charges__c lcTerminate = [select Id, Pre_Termination__c	,Start_Date__c, End_Date__c from Lease_Charges__c where id =: selectedLeaseCharge];
		
		if(leaseCharge.End_Date__c == null){
    		error = true;
    		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Select Termination Date.'));
    	}else if( leaseCharge.End_Date__c < lcTerminate.Start_Date__c){
    		error = true;
    		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Termination Date must be after Lease Charge Start Date'));
    	}else if(leaseCharge.End_Date__c > lcTerminate.End_Date__c ){
    		error = true;
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Termination Date must be before Lease Charge End Date'));
    	}else{
    		error = false;
    		dtString = DateTime.newInstance(leaseCharge.End_Date__c.year(),leaseCharge.End_Date__c.month(),leaseCharge.End_Date__c.day()).format('YYYY/MM/d');
    	}
    	if(!error){
    		if(leaseCharge != null || Test.isRunningTest()){
    			closePage = true;
    			lcTerminate.End_Date__c =  leaseCharge.End_Date__c;
    			lcTerminate.Pre_Termination__c	 = true;
    			
    			List<Rent_Schedules__c> rsList=[Select Id,Status__c,Start_Date__c, End_Date__c, Lease_Charge__c, Lease_Charge__r.Start_Date__c, Lease_Charge__r.End_Date__c from Rent_Schedules__c where Lease_Charge__c =:lcTerminate.Id];
    			if(rsList.size() > 0){
    				for(Rent_Schedules__c rs: rsList){ 
    					if(rs.Status__c == 'Rent Roll Generated' && rs.Start_Date__c >= leaseCharge.End_Date__c && rs.End_Date__c >= leaseCharge.End_Date__c){
    							error = true;
    							closePage = false;
    							ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Rent Roll already generated for this Lease Charge and cannot be Terminated.'));
    					}else{
    						if(rs.Start_Date__c > leaseCharge.End_Date__c){
	    						rs.Status__c = 'Terminated';
			                    rs.Approved__c = true;
	    					}else if(rs.Start_Date__c < leaseCharge.End_Date__c && rs.End_Date__c > leaseCharge.End_Date__c){
	    						rs.End_Date__c = leaseCharge.End_Date__c;
	    					}
    					}
    				}
    			}
    			if(!error)
	    			try{
						update lcTerminate;
						//update rsList; removed because RS is terminated from LC via Trigger. here rsList is used just for validation
		            }catch(Exception e){
		            	Database.rollback(sp);
		            	closePage = false;
		            	error = true;
		            	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Exception Occured- '+e));
		            }
    		}
    	}
    	
    }
}