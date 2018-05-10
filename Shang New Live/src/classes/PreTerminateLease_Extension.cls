/*
    Name    :   PreTerminateLease_Extension
    Author  :   Arshad Shaikh (Techmatrix Consulting)
    Date    :   09/01/2017
    Description : This extension is used in  is used for PreTerminateLease Page.
            To Pre terminate Lease, Lease Unit, Rent Schedule and Lease Charges according to date input by user.
    Test Class: PreTerminate_Test
*/
public class PreTerminateLease_Extension {
    public Lease__c leaseOnUI{get;set;}
    public Boolean error{get;set;}
    public Boolean termError{get;set;}
    public String dtString{get;set;}
    public Boolean closePage{get;set;}
    public String selectedLease{get;set;}
    String currentEndDate{get;set;}
    Date EndDate{get;set;}
    public PreTerminateLease_Extension(ApexPages.StandardController stdController) {
        this.leaseOnUI = (Lease__c) stdController.getRecord();
        leaseOnUI.Lease_Start_Date__c = System.today();
        currentEndDate = ApexPages.currentpage().getParameters().get('endDate');
        selectedLease = ApexPages.currentpage().getParameters().get('selectedLease');

        if (currentEndDate != null && currentEndDate != '') {
            EndDate = date.parse(currentEndDate);
        }
    }

    public void checkDate() {
        SavePoint sp = Database.setSavePoint();
        error = false;
        termError = false;
        Lease__c lc = [select Id, Lease_Status__c,Pre_Terminated__c, Original_End_Date__c, Lease_Start_Date__c, Reason_for_Termination__c from Lease__c where Id =: selectedLease];

        if (leaseOnUI.Reason_for_Termination__c == null || leaseOnUI.Reason_for_Termination__c.trim() == '') {
            termError = true;
            error = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please add Reason for Termination'));
        }
        System.debug('leaseOnUI.Lease_Start_Date__c-->' + leaseOnUI.Lease_Start_Date__c);
        System.debug('EndDate-->' + EndDate);
        System.debug('(leaseOnUI.Lease_Start_Date__c > EndDate )-->' + (leaseOnUI.Lease_Start_Date__c > EndDate));
        if (leaseOnUI.Lease_Start_Date__c == null) {
            error = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please Select Termination Date'));
        } else if (leaseOnUI.Lease_Start_Date__c <= lc.Lease_Start_Date__c) {
            error = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Pre-Termination Date must be after Lease Start Date.'));
        } else if (leaseOnUI.Lease_Start_Date__c > EndDate) {
            error = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Pre-Termination Date must be before Revised End Date.'));
        } else {
            error = false;
            dtString = DateTime.newInstance(leaseOnUI.Lease_Start_Date__c.year(), leaseOnUI.Lease_Start_Date__c.month(), leaseOnUI.Lease_Start_Date__c.day()).format('YYYY/MM/d');
        }
        if (!error && !termError) {
            closePage = true;
            System.debug('lc--->' + lc);
            //lc.Lease_Status__c = 'Pre-Terminated';
            lc.Pre_Terminated__c = true;
            lc.Reason_for_Termination__c = leaseOnUI.Reason_for_Termination__c;
            lc.Original_End_Date__c = leaseOnUI.Lease_Start_Date__c;

            List < Lease_Unit__c > luList = [Select Id, Name, Original_End_Date__c,Pre_Termination__c, Lease_Start_Date__c, Lease_End_Date__c, Lease_Agreement_No__r.Lease_Start_Date__c, Lease_Agreement_No__r.Original_End_Date__c from Lease_Unit__c where Lease_Agreement_No__r.Id =: selectedLease];
            List < Rent_Schedules__c > rsList = new List < Rent_Schedules__c >();
            List < Lease_Charges__c > lcList = new List < Lease_Charges__c >();
            Set < Id > luIds = new Set < Id > ();
            if (luList.size() > 0) {
                try {
                    for (Lease_Unit__c lu: luList) {
                        if (lu.Lease_End_Date__c > leaseOnUI.Lease_Start_Date__c) {
                            lu.Pre_Termination__c = true;
                            lu.Reason_for_Termination__c = leaseOnUI.Reason_for_Termination__c;
                            //lu.Lease_Start_Date__c = lu.Lease_Agreement_No__r.Lease_Start_Date__c;
                            lu.Lease_End_Date__c = leaseOnUI.Lease_Start_Date__c;
                        }
                        luIds.add(lu.Id);
                    }
                    rsList = [Select Id, Status__c, Start_Date__c, End_Date__c, Lease_Unit__c, Lease_Unit__r.Lease_Start_Date__c, Lease_Unit__r.Lease_End_Date__c, Lease_Unit__r.Lease_Agreement_No__r.Lease_Start_Date__c, Lease_Unit__r.Lease_Agreement_No__r.Original_End_Date__c from Rent_Schedules__c where Lease_Unit__c =: luIds];
                    if (rsList.size() > 0) {
                        for (Rent_Schedules__c rs: rsList) {
                            if(rs.Status__c == 'Rent Roll Generated' && rs.Start_Date__c >= leaseOnUI.Lease_Start_Date__c && rs.End_Date__c >= leaseOnUI.Lease_Start_Date__c){
                                error = true;
                                closePage = false;
                                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Rent Roll already generated for this Lease and cannot be Terminated.'));
                            }else if (rs.Start_Date__c > leaseOnUI.Lease_Start_Date__c) {
                                rs.Status__c = 'Terminated';
                                rs.Approved__c = true;
                            } else if (rs.Start_Date__c < leaseOnUI.Lease_Start_Date__c && rs.End_Date__c > leaseOnUI.Lease_Start_Date__c) {
                                rs.End_Date__c = leaseOnUI.Lease_Start_Date__c;
                            }
                        }
                    }
                    lcList = [Select Id, Start_Date__c,Pre_Termination__c, End_Date__c, Lease_Unit__c, Lease_Unit__r.Lease_Start_Date__c, Lease_Unit__r.Lease_End_Date__c, Lease_Unit__r.Lease_Agreement_No__r.Lease_Start_Date__c, Lease_Unit__r.Lease_Agreement_No__r.Original_End_Date__c from Lease_Charges__c where Lease_Unit__c =: luIds];
                    if (lcList.size() > 0) {
                        for (Lease_Charges__c lcl: lcList) {
                            lcl.Pre_Termination__c = true;
                            if (lcl.End_Date__c > leaseOnUI.Lease_Start_Date__c && lcl.Start_Date__c < leaseOnUI.Lease_Start_Date__c) {
                                lcl.End_Date__c = leaseOnUI.Lease_Start_Date__c;
                            }
                        }
                    }

                } catch (Exception e) {
                    closePage = false;
                    error = true;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Exception Occured- ' + e));
                }
            }
            if(!error){
                try {
                    update lc;
                    update luList;
                    //update rsList;
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