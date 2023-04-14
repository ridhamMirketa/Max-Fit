@RestResource(urlMapping='/Events/*')

global with sharing class GetEventEndPoint {
    @HttpGet
    global static List<Event__c> doGet() {
        List<Event__c> lEvent=[select Name__c,Start__c,Max_Seats__c,Organizer__r.Name,Organizer__r.email__c from Event__c];
        return lEvent;
    }
}