/**
* This is a trigger named EventSpeakerTrigger that is defined to fire before the insertion of Event_Speaker__c records. 
*/
trigger EventSpeakerTrigger on Event_Speaker__c (before insert) {
    // Check if the trigger is being executed before the insertion of Event_Speaker__c records
    if(Trigger.isBefore){
        // Check if the trigger is being executed for the insertion event
        if(Trigger.isInsert){
            // Call the helper class method to reject any duplicate booking
            EventSpeakerTriggerHelper.rejectDuplicateBooking(Trigger.new);
        }
    }
    
}