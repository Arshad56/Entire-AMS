trigger SetPoName on Purchase_Order__c (before Insert) {
    Set<Id> propIds = new Set<Id>();
    for(Purchase_Order__c po:Trigger.New){
        if(po.Property__c!=null){
            propIds.add(po.Property__c);
        }
    }
    
    if(propIds.size()>0){
        Map<Id,Property__c> propMap = new Map<Id,Property__c>([Select id,Purchase_Order_Index__c,Short_Code__c from Property__c where id in:propIds]);
        
        List<Property__c> propertyList = new List<Property__c>();
        Set<Id> dupCheck = new Set<Id>();
        for(Purchase_Order__c po:Trigger.New){
            if(po.Property__c!=null && propMap.containsKey(po.Property__c)){
                property__c prop = propMap.get(po.Property__c);                    
                Integer IntIndex = 1;
                if(prop.Purchase_Order_Index__c!=null && prop.Purchase_Order_Index__c>0){
                    intIndex = Integer.valueOf(prop.Purchase_Order_Index__c);
                }
                
                Integer indexSize = string.valueOf(intIndex).length();
                
                string index = '';
                for(integer i =1;i<=6-indexSize;i++){
                    index += '0';
                }
                index += string.valueOf(intIndex);
                po.Name = prop.Short_Code__c+'-PO-'+system.today().Year()+(system.today().Month()<10?'0'+system.today().Month():''+system.today().Month())+(system.today().Day()<10?'0'+system.today().Day():''+system.today().Day())+'-'+index;
                prop.Purchase_Order_Index__c = intIndex + 1;
                if(!dupCheck.contains(prop.Id)){
                    propertyList.add(prop);
                    dupCheck.add(prop.Id);
                }
            }
        }
        
        if(propertyList.size()>0){
            update propertyList;
        }
    }
}