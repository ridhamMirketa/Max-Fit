public class DisplayEventSpeakerController {

    public String getEvent() {
        return null;
    }


    public Event__c EventDetails{get;set;}
    public list<Event_Speaker__c> lSpeakerDetails{get;set;}
    
    // public String Event__c.Organizer__r.Address__c {get;set;}
    public DisplayEventSpeakerController() {
        Id eventId = ApexPages.currentPage().getParameters().get('id');
        if(eventId!=null){
            EventDetails = [Select id, Name__c,Organizer__r.Name,Location__r.Name,Start__c from Event__c where id= :eventId];
            lSpeakerDetails = [Select id,Speaker__r.Name,Speaker__r.Profile_URL__c,Speaker__r.About_Me__c from Event_Speaker__c where Event__c =:EventDetails.Id ];
        }
        
        // system.debug(EventDetails);
        
    }

    public void s() {
        Savepoint sp=Database.setSavepoint();
        try{
            system.debug(lSpeakerDetails[0].Speaker__r.Name);

        }catch(Exception e){
            System.debug(e.getMessage());
            Database.rollback(sp);
        }
        
        
    }
    
}