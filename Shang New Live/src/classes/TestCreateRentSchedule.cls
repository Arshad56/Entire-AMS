@isTest
class TestCreateRentSchedule{
    
    static TestMethod void Test(){
        Rent_Schedule_Configuration__c rsc = new Rent_Schedule_Configuration__c();
        rsc.Name = 'Rent';
        rsc.Rental_Schedule_Generate__c = true;
        insert rsc;
    
        Property__c prop = new Property__c();
        prop.Name = 'TestProperty';
        insert prop;
        
        Level__c lvl = new Level__c();
        lvl.Name = 'TestLevel';
        lvl.Property__c = prop.Id;
        insert lvl;
        
        Units__c unt = new Units__c();
        unt.Property__c = prop.Id;
        unt.Level__c = lvl.Id;
        unt.Name = 'TestUnit';
        unt.Active__c = true;
        unt.Start_Date__c = system.today();
        unt.End_Date__c = system.today().addYears(2);
        insert unt;
    }
}