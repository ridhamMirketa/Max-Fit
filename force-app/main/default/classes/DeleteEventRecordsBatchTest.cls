@isTest
public with sharing class DeleteEventRecordsBatchTest {
    @isTest
    static void testDeleteEvents() {
         // Create test events that meet the criteria for deletion       
          List<Event__c> eventsToDelete = new List<Event__c>();
          for (Integer i = 0; i < 200; i++) {
            Event__c event = new Event__c();
            event.Name__c = 'Test ' + i;
            event.Start__c = Date.today().addMonths(-4);
            event.End__c = Date.today().addMonths(-3);
            event.Live__c = false;
            eventsToDelete.add(event);
        }
        insert eventsToDelete;
        Test.startTest();
        // Start the batch process        
        DeleteEventRecordsBatch batch = new DeleteEventRecordsBatch();
        Database.executeBatch(batch);
        Test.stopTest();
        // Verify that the events were deleted        
        List<Event__c> remainingEvents = [SELECT Id FROM Event__c];
        System.assertEquals(0, remainingEvents.size());
        // Verify that the admin received an email        
        List<EmailMessage> sentEmails = [SELECT Id, ToAddress FROM EmailMessage ];
        system.debug(sentEmails);
        System.assertEquals(1, sentEmails.size());
        System.assertEquals('ridham.godha18@gmail.com', sentEmails[0].ToAddress);
    }
}