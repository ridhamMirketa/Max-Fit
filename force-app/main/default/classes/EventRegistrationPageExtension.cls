public class EventRegistrationPageExtension {

    private ApexPages.StandardController controller;
    public Event__c Event { get; set; }
    public Event_Organizer__c org{get; set;}
    public Location_Address_Book__c loc{get;set;}
    // public String Event__c.Organizer__r.Address__c {get;set;}
    public EventRegistrationPageExtension(ApexPages.StandardController controller) {
        this.controller = controller;
        Event=new Event__c();
        org=new Event_Organizer__c();
        loc=new Location_Address_Book__c();
    }

    public void s() {
        Savepoint sp=Database.setSavepoint();
        try{
           	insert org;
            insert loc;
            Event.Organizer__c=org.id;
            Event.Location__c=loc.id;
            insert Event; 
        }catch(Exception e){
            System.debug(e.getMessage());
            Database.rollback(sp);
        }
        
        
    }
    
}