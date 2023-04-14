@isTest
public with sharing class EventSpeakerTriggerHelperTest {
    // Test method to verify that two events cannot have the same speaker
    @isTest
    private static void twoeventclashtest(){
        // Create first event with a speaker
        Event__c event1=new Event__c();
        event1.start__c=Datetime.newInstanceGmt(2023, 4, 18, 3, 3, 3);
        event1.end__c=Datetime.newInstanceGmt(2023, 4, 25, 3, 3, 3);
        event1.live__c=true;
        event1.Max_Seats__c=20.00;
        insert event1;

        // Create a speaker
        Speaker__c speaker1=new Speaker__c();
        speaker1.Name='Ridham';
        insert speaker1;

        // Assign the speaker to the first event
        Event_Speaker__c eventSpeaker1=new Event_Speaker__c();
        eventSpeaker1.Name='Rajesh';
        eventSpeaker1.Speaker__c=speaker1.id;
        eventSpeaker1.Event__c=event1.id;

        insert eventSpeaker1;
        try{
            
            Event__c event2=new Event__c();
            event2.start__c=Datetime.newInstanceGmt(2023, 4, 20, 3, 3, 3);
            event2.end__c=Datetime.newInstanceGmt(2023, 4,27, 3, 3, 3);
            event2.live__c=true;
            event2.Max_Seats__c=20.00;
            
            insert event2;

            Event_Speaker__c eventSpeaker2=new Event_Speaker__c();
            eventSpeaker2.Name='Kamal';
            eventSpeaker2.Speaker__c=speaker1.id;
            eventSpeaker2.Event__c=event2.id;

            insert eventSpeaker2;
            
        }
        catch(Exception e){
            // Verify that the expected exception is thrown when trying to insert an event with the same speaker as the first event
            Boolean expectedExceptionThrown =  e.getMessage().contains('Duplicate Speaker found in Event-Speaker records') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        }
        

        




    }

}