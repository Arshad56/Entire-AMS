trigger MainMeterTrigger on Electric_Meter__c (after insert, after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        MainMeterTrigger_Helper.checkDuplicateMeters(Trigger.new);
     
        if(trigger.isInsert){
            EletricMeterController.executePushElectricMeterAPI('insert', Trigger.New, null);           
        }else if(trigger.isUpdate){
            EletricMeterController.executePushElectricMeterAPI('update', Trigger.New, Trigger.Old);     
        }
      
    }
}