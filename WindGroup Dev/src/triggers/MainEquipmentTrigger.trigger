trigger MainEquipmentTrigger on Equipment__c (before Insert, before update) {
    if(checkRecursive.runOnce()){
        if(Trigger.isBefore && Trigger.isInsert){
            Set<Id> propertyIds = new Set<Id>();
            for(Equipment__c eq: Trigger.new){
            
                if(eq.Property__c != null){
                    propertyIds.add(eq.Property__c);
                }
            }
        
            if(propertyIds.size() > 0){ 
                MainEquipment_Helper.generateEQName(propertyIds,Trigger.new); 
            }
        }
        
        if(Trigger.isBefore && Trigger.isUpdate){
  	
            Set<Id> equipmentIds = new Set<Id>();
            for(Equipment__c eq: Trigger.new){
                if(eq.Action__c.equals('Write Off'))
                {
                    equipmentIds.add(eq.Id);
                }
            }
    
            if(equipmentIds.size() > 0){ 
                WriteOffController wrc = new WriteOffController(equipmentIds,null);
                wrc.writeOff(); 
            }   
        }
    }  
}