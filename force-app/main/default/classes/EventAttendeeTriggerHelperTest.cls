@isTest
public with sharing class EventAttendeeTriggerHelperTest {
    // This method tests that an email is sent to the attendee when an Event_Attendee__c record is inserted with a valid email address.
    @isTest
    private static void validateEmailTest(){
        // Start the test
        test.startTest();

        // Create a test Location_Address_Book__c record
        Location_Address_Book__c location1=new Location_Address_Book__c();
        location1.name='Parshwanath colony';
        location1.City__c='Ajmer';
        insert location1;

        // Create a test Event_Organizer__c record
        Event_Organizer__c organizer1=new Event_Organizer__c();
        organizer1.name='rajesh';
        insert organizer1;

         // Create a test Event__c record
        Event__c event1=new Event__c();
        event1.name__c='Ridham';
        event1.start__c=Datetime.newInstanceGmt(2023, 4, 18, 3, 3, 3);
        event1.end__c=Datetime.newInstanceGmt(2023, 4, 25, 3, 3, 3);
        event1.live__c=true;
        event1.Max_Seats__c=20.00;
        event1.Event_Type__c='In-Person';
        event1.Location__c=location1.id;
        event1.Organizer__c=organizer1.id;
        insert event1;

        // Create a test Attendees__c record
        Attendees__c attendee1=new Attendees__c();
        attendee1.name='Rahul';
        attendee1.email__c='ridham.godha18@gmail.com';
        insert attendee1;

        // Create a test Event_Attendee__c record and insert it
        Event_Attendee__c eventAttendee1=new Event_Attendee__c();
        eventAttendee1.Name='E001';
        eventAttendee1.Event__c=event1.id;
        eventAttendee1.Attendee__c=attendee1.id;
        
        insert eventAttendee1;
        
        // Query the EmailMessage records that were sent and verify that only one email was sent to the correct email address
        List<EmailMessage> sentEmails = [SELECT Id, ToAddress FROM EmailMessage ];
        system.debug(sentEmails);
        System.assertEquals(1, sentEmails.size());
        System.assertEquals('ridham.godha18@gmail.com', sentEmails[0].ToAddress);

        // Stop the test
        test.stopTest();


    }

    // This method tests that an exception is thrown when an Event_Attendee__c record is inserted with a blank email address.
    @istest
    private static void fieldValueNUllTest(){
        // Start the test
        test.startTest();

        // Create a test Location_Address_Book__c record
        Location_Address_Book__c location1=new Location_Address_Book__c();
        location1.name='Parshwanath colony';
        location1.City__c='Ajmer';
        insert location1;

        // Create a test Event_Organizer__c record
        Event_Organizer__c organizer1=new Event_Organizer__c();
        organizer1.name='rajesh';
        insert organizer1;

        // Create a test Event__c record
        Event__c event1=new Event__c();
        event1.name__c='Ridham';
        event1.start__c=Datetime.newInstanceGmt(2023, 4, 18, 3, 3, 3);
        event1.end__c=Datetime.newInstanceGmt(2023, 4, 25, 3, 3, 3);
        event1.live__c=true;
        event1.Max_Seats__c=20.00;
        event1.Event_Type__c='In-Person';
        event1.Location__c=location1.id;
        event1.Organizer__c=organizer1.id;
        insert event1;

        // Create a new attendee record with a blank email field
        Attendees__c attendee1=new Attendees__c();
        attendee1.name='Rahul';
        attendee1.email__c='';
        insert attendee1;

        Boolean exceptionOccurred=false;
        try{
            // Try to insert a new event attendee record with a blank email
            Event_Attendee__c eventAttendee1=new Event_Attendee__c();
            eventAttendee1.Name='E001';
            eventAttendee1.Event__c=event1.id;
            eventAttendee1.Attendee__c=attendee1.id;
            
            insert eventAttendee1;
        }catch(Exception e){
            // If an exception is thrown, set the flag to true
            exceptionOccurred=true;
        }
        // Assert that an exception was thrown during the insert
        system.assert(exceptionOccurred);
        test.stopTest();
    }
}