@IsTest
public class PostSpeakerEndPointTest {
    @IsTest
    private static void testCreatSpeaker(){
        
        test.startTest();
        RestContext.response =new RestResponse();
        Id speakerId=PostSpeakerEndPoint.doPost('rs5a3433543me34e32shdf','riadfd2323fham.goddffha18@gmaial.com','4er332e232a33534','mir45453erafa323df') ;
        if(speakerId!=null){
            Speaker__c sp=[select name,Email__c,Phone__c,Company__c from Speaker__c where id=:speakerId];
        
            System.assertEquals('rs5a3433543me34e32shdf', sp.name);
            System.assertEquals(200, RestContext.response.statusCode);
        }
        
        
        test.stopTest();
    }

    private static void testDuplicateSpeaker(){
        
        test.startTest();
        RestContext.response =new RestResponse();
        Id speakerId2=PostSpeakerEndPoint.doPost('rs5a3433543me34e32shdg','riadfd2323fhamg.goddffha18@gmgaial.com','4er332e232ga33534','mir4545g3erafa323df') ;
        System.assertEquals(200,RestContext.response.statusCode);
        Id speakerId1=PostSpeakerEndPoint.doPost('rs5a3433543me34e32shdg','riadfd2323fhamg.goddffha18@gmgaial.com','4er332e232ga33534','mir4545g3erafa323df') ;
       
        
        // Speaker__c sp=[select name,Email__c,Phone__c,Company__c from Speaker__c where id=:speakerId];
    
        System.assertEquals(400,RestContext.response.statusCode);
        System.assertEquals(null, speakerId1);
        test.stopTest();
    } 
}