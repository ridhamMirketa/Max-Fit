global class DeleteEventRecordsBatch implements Database.Batchable<sObject> {
    // The class definition starts here, implementing the Batchable interface for sObjects
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // This method returns a QueryLocator, which is used to locate the records to process in the execute() method
        // The query retrieves Event__c records where End__c date is more than two months ago and Live__c field is FALSE
        return Database.getQueryLocator([
            SELECT Id, End__c,Live__c
            FROM Event__c
            WHERE End__c < LAST_N_MONTHS: 2 ANd Live__c=FALSE
        ]);
    }
    
    global void execute(Database.BatchableContext BC, List<Event__c> Events) {
        // This method processes the records retrieved by start() method, which is passed as a List parameter
        
            delete Events; // Deletes the records
        
    }
    
    global void finish(Database.BatchableContext BC) {
        // This method is called after all batches have been executed
        
        // Creates a SingleEmailMessage instance to send an email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{'ridham.godha18@gmail.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Batch Job Completed');
        mail.setPlainTextBody('Execution of the batch has been processed. ');

        // Sends the email and stores the results in a SendEmailResult array
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        // Loops through each result and prints success message if the email was sent successfully, or error message if it failed
        for (Messaging.SendEmailResult result : results) {
            if (result.isSuccess()) {
                System.debug('Email sent successfully.');
            } else {
                System.debug('Email could not be sent: ' + result.getErrors()[0].getMessage());
            }
        }
    }
}