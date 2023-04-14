public with sharing class EventAttendeeTriggerHelper {
    // Define a virtual BaseException class and a subclass OtherException
    public virtual class BaseException extends Exception {}
    public class OtherException extends BaseException {}

    // Define a static method to send emails to Event Attendees
    public static void sendMailTOAttendee(List<Event_Attendee__c> newEventAttendeeRecords){

        // Create a list to store Event Attendee record IDs and a list to store email messages
        List<Id> eventAttendeeId=new List<Id>();
        List<Messaging.Email> emailList=new List<Messaging.Email>();

        // Loop through new Event Attendee records and add their IDs to the eventAttendeeId list
        for(Event_Attendee__c eventAttendeeObj:newEventAttendeeRecords){
            eventAttendeeId.add(eventAttendeeObj.Id);
        }
        // Use a query to retrieve Event Attendee, Attendee, Event, and Location records based on their IDs
        Map<id,Event_Attendee__c> eventAttendeeDetails=new Map<id,Event_Attendee__c>([select Attendee__r.Email__c,Attendee__r.Name,Event__r.Name__c,Event__r.Start__c,Event__r.Location__r.Name,Event__r.Organizer__r.Name from Event_Attendee__c where id in : eventAttendeeId]);
        
        
        // Loop through the retrieved records and create an email message for each Event Attendee
        for(Id recordId: eventAttendeeDetails.KeySet()){
            String email=eventAttendeeDetails.get(recordId).Attendee__r.Email__c;
            String attendeeName=eventAttendeeDetails.get(recordId).Attendee__r.Name;
            String eventName= eventAttendeeDetails.get(recordId).Event__r.Name__c;
            Datetime eventDate=eventAttendeeDetails.get(recordId).Event__r.Start__c;
            String eventLocation=eventAttendeeDetails.get(recordId).Event__r.Location__r.Name;
            String eventOrganizer=eventAttendeeDetails.get(recordId).Event__r.Organizer__r.Name;
            
            if(email!=NULL && attendeeName!=NULL && eventName!=NULL && eventDate!=NULL && eventLocation!=NULL && eventOrganizer!=NULL){
                
                  Messaging.SingleEmailMessage emailMsg=new Messaging.SingleEmailMessage();
                  emailMsg.setToAddresses(new String[]{email});
                  String emailSubject='Pass for the '+ eventName;
                  emailMsg.setSubject(emailSubject);
                  String senderName='Ridham';
                  emailMsg.setSenderDisplayName(senderName);
                  String body='Dear ' + attendeeName+ ',<br/> Thank you for registering for '+ eventName+
                  ' which will be organized on '+ eventDate +' and will be held in ' + eventLocation+ '.We are excited to have you, see you at the event. <br/><br/> Thanks,<br/>'+eventOrganizer; 
                  emailMsg.setHtmlBody(body);
                  emailList.add(emailMsg);
              }else{
                // If any required field is null, throw OtherException with an error message
                throw new OtherException('Either Email or Attendee Name or Event Name or event date or event Location or event Organizer is NULL');
              }
         }
          // Send email messages in the emailList using the Messaging.sendEmail method
          Messaging.sendEmail(emailList);
         
    }
}