@RestResource(urlMapping='/Speakers/*')

global with sharing class PostSpeakerEndPoint {
    @HttpPost
    global static Id doPost(String name, String email,
        String phone, String company) {
            try{
                
                Speaker__c speakerRecord = new Speaker__c(
                Name=name,
                Email__c=email,
                Phone__c=phone,
                Company__c=company);

                insert speakerRecord;
                Id speakerId=speakerRecord.id;
                RestContext.response.statusCode=200;
                // system.debug(speakerId);
                return speakerId;
                
            }catch(Exception e){
                RestContext.response.statusCode=400;
                // system.debug('hell');
                return null;
                // return 'fail';
            }
            
        
    }   
}