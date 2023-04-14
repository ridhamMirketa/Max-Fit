public class AttendeeRegistrationPageExtension {

    private ApexPages.StandardController controller;
    public Attendees__c attendee{get;set;}
    public Event_Attendee__c eventAttendee{get;set;}
    public Location_Address_Book__c	 loc{get;set;}
    // public String Event__c.Organizer__r.Address__c {get;set;}
    public AttendeeRegistrationPageExtension(ApexPages.StandardController controller) {
        this.controller = controller;
        attendee=new Attendees__c();
        eventAttendee=new Event_Attendee__c();
        loc=new Location_Address_Book__c();
        
    }

    public void s() {
        Savepoint sp=Database.setSavepoint();
        try{
            insert loc;
           attendee.Address__c=loc.id;
           insert attendee;
           eventAttendee.Attendee__c=attendee.id;
           insert eventAttendee;

        }catch(Exception e){
            System.debug(e.getMessage());
            Database.rollback(sp);
        }
        
        
    }
    
}