public class SpeakerRegistrationPageExtension {

    private ApexPages.StandardController controller;
    public Speaker__c speaker{get;set;}
    public Event_Speaker__c eventSpeaker{get;set;}
    // public String Event__c.Organizer__r.Address__c {get;set;}
    public SpeakerRegistrationPageExtension(ApexPages.StandardController controller) {
        this.controller = controller;
        speaker=new Speaker__c();
        eventSpeaker=new Event_Speaker__c();
        
    }
    public void s() {
        Savepoint sp=Database.setSavepoint();
        try{
           	insert speaker;
            eventSpeaker.Speaker__c=speaker.id;
            insert eventSpeaker;
            
        }catch(Exception e){
            System.debug(e.getMessage());
            Database.rollback(sp);
        }
    }
}