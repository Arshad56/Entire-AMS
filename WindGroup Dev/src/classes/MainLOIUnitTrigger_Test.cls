@isTest(seeAllData=false)
public with sharing class MainLOIUnitTrigger_Test {
   static Property__c prop;
   static Units__c unt;
   static LOI_Unit__c lu;
   static LOI_Unit__c lu2;
    static void init(){
         prop = new Property__c();
        prop.Name = 'TestProperty';
        insert prop;
        
        Level__c lvl = new Level__c();
        lvl.Name = 'TestLevel';
        lvl.Property__c = prop.Id;
        insert lvl;
        
        unt = new Units__c();
        unt.Property__c = prop.Id;
        unt.Level__c = lvl.Id;
        unt.Name = 'TestUnit';
        unt.Generate_Lease_Plans__c = true;
        unt.Active__c = true;
        unt.Start_Date__c = system.today();
        unt.End_Date__c = system.today().addYears(1);
        unt.Charge_Method__c = 'Monthly Rate - CL';
        insert unt;
        
        Account acc = new Account();
        acc.Name = 'TestTenant';
        insert acc;
        
        LOI__c ls = new LOI__c();
        ls.Tenant__c = acc.Id;
        ls.Property__c = prop.Id;        
        insert ls;
        
        Lease_Plan__c lp = new Lease_Plan__c();
        lp.Unit__c = unt.Id;
        lp.Start_Date__c = unt.Start_Date__c;
        lp.End_Date__c = Date.newInstance(unt.Start_Date__c.year(),unt.Start_Date__c.month(),Date.DaysInMonth(unt.Start_Date__c.Year(),unt.Start_Date__c.Month()));
        for(Date dts=unt.Start_Date__c;dts<=lp.End_Date__c; dts = dts+1){
            lp.put('Daily_Rate_'+dts.Day()+'__c',dts.day());
            
            if(dts.Day() > 0 && dts.Day() < 7){
                lp.put('Status_'+dts.Day()+'__c','Committed');
            }else if(dts.Day() > 7 && dts.Day() < 15){
                lp.put('Status_'+dts.Day()+'__c','Vacant');
            }else if(dts.Day() > 17 && dts.Day() < 25){
                lp.put('Status_'+dts.Day()+'__c','LOI');
            }
        }
        insert lp;
        
        lu = new LOI_Unit__c();
        lu.LOI_Agreement_No__c = ls.Id;
        lu.Unit__c = unt.Id;
        lu.LOI_Start_Date__c = unt.Start_Date__c+2;
        lu.LOI_End_Date__c = lu.LOI_Start_Date__c+3;
        lu.Update_LOI_Plans__c = true;
        
        lu2 = new LOI_Unit__c();
        lu2.LOI_Agreement_No__c = ls.Id;
        lu2.Unit__c = unt.Id;
        lu2.LOI_Start_Date__c = lu.LOI_End_Date__c+30;
        lu2.LOI_End_Date__c = lu2.LOI_Start_Date__c+5;
        insert lu2;
        
        
    }
     static testMethod void Test(){
         init();
         Test.startTest();
         insert lu;
         
         Test.stopTest();
     }
       static testMethod void Test1(){
         init();
         Test.startTest();
         lu2.Update_LOI_Plans__c = true;
         update lu2;
         Test.stopTest();
     }      
}