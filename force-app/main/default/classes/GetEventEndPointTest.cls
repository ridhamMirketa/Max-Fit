@IsTest
public class GetEventEndPointTest {
    @IsTest
    private static void testGetEvents(){
        createTestRecord();
        test.startTest();
        // Set up a test request

        // RestRequest request = new RestRequest();
        // request.requestUri =
        //     'https://mirketainc11-dev-ed.develop.lightning.force.com/services/apexrest/Events/';
        // request.httpMethod = 'GET';
        // RestContext.request = request;
        // Call the method to test
        // Http http = new Http();
        // HttpRequest request = new HttpRequest();
        // HttpResponse response;

        // request.setEndpoint('https://mirketainc11-dev-ed.develop.lightning.force.com/services/apexrest/Events/');
        // request.setMethod('GET');
        // response = http.send(request);
        // System.debug('hi'+response.getBody());
        List<Event__c> events  = GetEventEndPoint.doGet();
        // Verify results
        
        System.assertEquals('Raman', events[0].Name__c);

        test.stopTest();
    }
    // Helper method
    static void createTestRecord() {
        // Create test record
        Datetime myDateTime = Datetime.newInstance(1960, 2, 17);
        Event_Organizer__c organizerTest=new Event_Organizer__c(
            Name='roman',
            Email__c='ridham.godha18@gmail.com'
        );
        insert organizerTest;
        Event__c eventTest = new Event__c(
            Name__c='Raman',
            Start__c=myDateTime,
            Max_Seats__c=30,
            Organizer__c=organizerTest.id
           );

        insert eventTest;
        
        
    }     
}