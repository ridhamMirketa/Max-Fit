/**
 * This is a helper class named EventSpeakerTriggerHelper which is used by the EventSpeakerTrigger trigger. 
 * It contains a single static method called 'rejectDuplicateBooking' which takes a list of new Event_Speaker__c records as input 
 * and checks for any duplicate bookings for the same speaker and event combination. If any duplicate booking is found, 
 * it throws an error and stops the insertion of the new records.
 */
public without sharing class EventSpeakerTriggerHelper {
    
    public static void rejectDuplicateBooking(List<Event_Speaker__c> newRecords){
        // Create two lists to store the Ids of events and speakers from the new Event_Speaker__c records being inserted
        List<Id> eventId=new List<Id>();
        List<id> speakerIds=new List<Id>();
        // Iterate through the new records to extract the event and speaker Ids and add them to their respective lists
        for(Event_Speaker__c es: newRecords){
            eventId.add(es.Event__c);
            speakerIds.add(es.Speaker__c);
        }

        // Create a Map to store the event details of the new Event_Speaker__c records being inserted, 
        // by querying the Event__c object for start and end dates of the events associated with the event Ids
        Map<id,Event__c> newRecordsEventDetails=new Map<id,Event__c>([select Start__c,End__c from Event__c where id in: eventId]);
        
        // Create a Map to store the old Event_Speaker__c records for each speaker, 
        // by querying the Event_Speaker__c object for all records that have the same speaker Ids as the new records
        Map<id,List<Event_Speaker__c>> oldEventSpeakerRecords=new Map<id,List<Event_Speaker__c>>();
        for(Event_Speaker__c oldEventSpeakerRecord:[select id,Event__r.Start__c,Event__r.End__c,Speaker__c from Event_Speaker__c where Speaker__c in:speakerIds]){
            if (oldEventSpeakerRecords.containsKey(oldEventSpeakerRecord.Speaker__c)){
                oldEventSpeakerRecords.get(oldEventSpeakerRecord.Speaker__c).add(oldEventSpeakerRecord);
            }
            else{
                oldEventSpeakerRecords.put(oldEventSpeakerRecord.speaker__c, new List<Event_Speaker__c>{oldEventSpeakerRecord});
            }
        }
        // Check if any old Event_Speaker__c records exist for the same speaker and event combination as the new records
        if(!oldEventSpeakerRecords.isEmpty()){
            for(Event_Speaker__c getEventSpeakerRecords:newRecords){

                // Extract the start and end dates and speaker Id from the new Event_Speaker__c record being processed
                datetime start=newRecordsEventDetails.get(getEventSpeakerRecords.Event__c).Start__c;
                datetime endDate=newRecordsEventDetails.get(getEventSpeakerRecords.Event__c).End__c;
                Id speakerId=getEventSpeakerRecords.speaker__c;
        
                List<Event_Speaker__c> recordOfEachSpeakerId=new List<Event_Speaker__c>();
                recordOfEachSpeakerId=oldEventSpeakerRecords.get(speakerId);
                // Iterate through each old record to check if there is any overlap in the event dates 
                // between the old and new Event_Speaker__c records being processed
                for(Event_Speaker__c oldRecord: recordOfEachSpeakerId){
                datetime oldStart=oldRecord.Event__r.start__c;
                datetime oldEnd=oldRecord.Event__r.End__c;
                
                    if((oldStart>=start && oldStart<=endDate) || (oldEnd>=start && oldEnd<=endDate)||(oldStart<=start && oldEnd>=endDate)){
                            getEventSpeakerRecords.addError('Duplicate Speaker found in Event-Speaker records');
                            break;
                        }
                    }
            
            }
        }
        

    }   
}