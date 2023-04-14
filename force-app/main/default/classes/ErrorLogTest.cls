@IsTest
public class ErrorLogTest {
    @IsTest
    private static void insertErrorLogTest(){
        test.startTest();
        DateTime dt = DateTime.now();
        id errorRecordId=ErrorLog.insertErrorLog(dt, 'ErrorDetailsTest', 'test', 'testlog');
        Error_Log__c newLog=new Error_Log__c();
        newLog=[select 	Process_Name__c from Error_Log__c where id= : errorRecordId];

        system.assertEquals('test', newLog.Process_Name__c);

        test.stopTest();
    }
}