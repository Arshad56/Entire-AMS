trigger RequestTrigger on Request__c(before insert,before update,before delete,after insert,after update,after delete)
{
     if(Trigger.isInsert)
    {
        if(Trigger.isBefore)
        {
            try
            {
                ActionTypeAndDateTimeAssignmentHelper.ProcessActionTypeDateTime(Trigger.new);
            }
            catch(Exception e)
            {
                system.debug(e);
            }    
        }
        else if(Trigger.isAfter)
        {
        
        }
    }
    else if(Trigger.isUpdate)
    {
        if(Trigger.isBefore)
        {
            try
            {
                ActionTypeAndDateTimeAssignmentHelper.ProcessActionTypeDateTime(Trigger.new);
            }
            catch(Exception e)
            {
                system.debug(e);
            }
        }
        else if(Trigger.isAfter)
        {
        
        }
    }
    
}