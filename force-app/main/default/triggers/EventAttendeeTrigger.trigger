// This is an Apex trigger that fires after a new Event_Attendee__c record is inserted
trigger EventAttendeeTrigger on Event_Attendee__c (After insert) {
    // Check if the trigger is running after the insert event
    if(Trigger.isAfter){
        // Check if the trigger is running because of a new record insert
        if(Trigger.isInsert){
            // Call the sendMailTOAttendee method in the EventAttendeeTriggerHelper class.
            EventAttendeeTriggerHelper.sendMailTOAttendee(Trigger.new);
        }
    }
}