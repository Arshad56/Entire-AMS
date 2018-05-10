@istest
public class NewLeasePOSRedirectControllertest {
    static testmethod void testNewLeasePOSRedirectController(){
    
     Account ac=new Account();
        ac.Name='TestAc';
        insert ac;
        
        Property__c Prop=new Property__c();
        prop.name='testProp';
        prop.Short_Code__c='abc';
        insert prop;
        
        Lease__c l=new Lease__c();
        l.Tenant__c=ac.Id;
        l.Rent_Free_Start_Date__c=date.today();
        l.Rent_Free_End_Date__c=date.today()+5;
        
        l.Property__c=prop.Id;
        l.Lease_Start_Date__c=date.today();
        l.Lease_Tenure_Mths__c=10;
        l.Lease_Tenure_Days__c='5';
        l.Lease_Status__c='new';
        insert l;
        
        
          
        Level__c le = new Level__c();
        le.Name = 'abc';
        le.Property__c = prop.id;
        insert le;
        
        Units__c un = new Units__c();
        un.Property__c =prop.id;
        un.Level__c = le.id;
        //un.Unit_No__c ='123';
         un.Active__c =true;
        un.NLA_SQF__c =1.0;
        un.Charge_Method__c = 'daily rate';
        un.Start_Date__c =date.today();
        un.End_Date__c = date.today()+5;
        insert un;
        
        Lease__c ls = new Lease__c();
        ls.Tenant__c = ac.id;
        ls.Property__c =prop.id;
        ls.Lease_Start_Date__c =date.today()+5;
        ls.Lease_Tenure_Mths__c = 12;
        ls.Lease_Tenure_Days__c ='18';
        ls.Lease_Status__c ='New';
        insert ls;
        
       
        
        Lease_Unit__c lu = new Lease_Unit__c();
        lu.Lease_Agreement_No__c =ls.id;
        lu.Unit__c = un.id;
        lu.Lease_Start_Date__c =date.today();
          lu.Lease_End_Date__c =date.today() + 1;
        insert lu;
        
        
         Lease_POS__c lp = new Lease_POS__c();
        lp.Lease_Unit__c = lu.id;
        try{
        insert lp;
        }catch(exception e){}
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(lp);
        NewLeasePOSRedirectController testAccPlan = new NewLeasePOSRedirectController(sc);
        
}   
}