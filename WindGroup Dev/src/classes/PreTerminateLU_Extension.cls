public  class PreTerminateLU_Extension {
    public Lease_Unit__c lu{get;set;}
    public Boolean termError{get;set;}
    public Boolean error{get;set;}
    public Boolean closePage{get;set;}
    public String dtString{get;set;}
    public String selectedLU{get;set;}
    String currentEndDate{get;set;}
    Date EndDate{get;set;}
    public PreTerminateLU_Extension(ApexPages.StandardController stdController) {
        this.lu = (Lease_Unit__c) stdController.getRecord();
        lu.Lease_End_Date__c = System.today();
        currentEndDate = ApexPages.currentpage().getParameters().get('endDate');
        selectedLU = ApexPages.currentpage().getParameters().get('selectedLeaseUnits');

        if (currentEndDate != null && currentEndDate != '') {
            EndDate = date.parse(currentEndDate);
        }
        error = true;
    }

    public void checkDate() {
    	SavePoint sp = Database.setSavePoint();
        error = false;
        termError = false;

        Lease_Unit__c leaseUnit = [Select Id, Name,Pre_Termination__c, Original_End_Date__c, Lease_Start_Date__c, Lease_End_Date__c, Lease_Agreement_No__r.Lease_Start_Date__c, Lease_Agreement_No__r.Lease_End_Date__c from Lease_Unit__c where Id =: selectedLU];

        if (lu.Reason_for_Termination__c == null || lu.Reason_for_Termination__c.trim() == '') {
            termError = true;
            error = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please add Reason for Termination'));
        }

        if (lu.Lease_End_Date__c == null) {
            error = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please Select Termination Date.'));
        } else if (lu.Lease_End_Date__c <= leaseUnit.Lease_Start_Date__c) {
            error = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Termination Date must be after Lease Unit Start Date'));
        } else if (lu.Lease_End_Date__c > leaseUnit.Lease_End_Date__c) {
            error = true;
            if (lu.Lease_End_Date__c > leaseUnit.Lease_End_Date__c) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Termination Date must be before Lease Unit End Date'));
            } else {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Termination Date must be before Lease Unit Original End Date'));
            }
        } else {
            error = false;
            dtString = DateTime.newInstance(lu.Lease_End_Date__c.year(), lu.Lease_End_Date__c.month(), lu.Lease_End_Date__c.day()).format('YYYY/MM/d');
        }

        if (!error && !termError) {

            if (leaseUnit != null || Test.isRunningTest()) {
                closePage = true;
                leaseunit.Pre_Termination__c = true;
                leaseUnit.Reason_for_Termination__c = lu.Reason_for_Termination__c;
                leaseUnit.Lease_Start_Date__c = lu.Lease_Agreement_No__r.Lease_Start_Date__c;
                if (leaseUnit.Original_End_Date__c == null) {
                    leaseUnit.Original_End_Date__c = leaseUnit.Lease_End_Date__c;
                }
                leaseUnit.Lease_End_Date__c = lu.Lease_End_Date__c;
                
                List<Lease_POS__c> posList = [select Id, End_Date__c, Start_Date__c, Status__c from Lease_POS__c where Lease_Unit__c =: selectedLU And (Start_Date__c >=: lu.Lease_End_Date__c or End_Date__c >=: lu.Lease_End_Date__c)];
                for(Lease_POS__c lpos:posList){
                	lpos.Start_Date__c = (lpos.Start_Date__c > lu.Lease_End_Date__c)?lu.Lease_End_Date__c:lpos.Start_Date__c;
                	lpos.End_Date__c = lu.Lease_End_Date__c;
                }
                    List < Rent_Schedules__c > rsList = [Select Id, Status__c, Start_Date__c, End_Date__c, Lease_Unit__c, Lease_Unit__r.Lease_Start_Date__c, Lease_Unit__r.Lease_End_Date__c from Rent_Schedules__c where Lease_Unit__c =: selectedLU];
                    if (rsList.size() > 0) {
                        for (Rent_Schedules__c rs: rsList) {
                            if(rs.Status__c == 'Rent Roll Generated' && rs.Start_Date__c >= lu.Lease_End_Date__c && rs.End_Date__c >= lu.Lease_End_Date__c){
                            	error = true;
                            	closePage = false;
    							ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Rent Roll already generated for this Lease Unit and cannot be Terminated.'));
                            }else if (rs.Start_Date__c > lu.Lease_End_Date__c) {
                                rs.Status__c = 'Terminated';
                                rs.Approved__c = true;
                            } else if (rs.Start_Date__c < lu.Lease_End_Date__c && rs.End_Date__c > lu.Lease_End_Date__c) {
                                rs.End_Date__c = lu.Lease_End_Date__c;
                            }
                        }
                        
                    }

                    List< Lease_Charges__c > lcList = [Select Id,Pre_Termination__c, Start_Date__c, End_Date__c, Lease_Unit__c, Lease_Unit__r.Lease_Start_Date__c, Lease_Unit__r.Lease_End_Date__c from Lease_Charges__c where Lease_Unit__c =: selectedLU];
                    if (lcList.size() > 0) {
                        for (Lease_Charges__c lcl: lcList) {
                        	lcl.Pre_Termination__c = true;
                            if (lcl.End_Date__c > lu.Lease_End_Date__c && lcl.Start_Date__c < lu.Lease_End_Date__c) {
                                lcl.End_Date__c = lu.Lease_End_Date__c;
                            }
                        }
                        
                    }
                if(!error)
	                try {
	                	update leaseUnit;
	                	update posList;
	                	//update rsList; removed because RS is terminated from LC via Trigger. here rsList is used just for validation
	                	update lcList;
	                } catch (Exception e) {
	                	Database.rollback(sp);
	                    closePage = false;
	                    error = true;
	                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Exception Occured- ' + e));
	                }
            }
        }
    }
}