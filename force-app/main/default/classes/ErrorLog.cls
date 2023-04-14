/**
* The purpose of this method is to create a new record of Error_Log__c object and insert it into the database. 
* This method returns the Id of the newly created Error_Log__c record. 
*/
public with sharing class ErrorLog {
    public static Id insertErrorLog(Datetime dt,String logDetails, String processName,String errorLogName ){
        // Create a new instance of Error_Log__c object
        Error_Log__c newLogObj=new Error_Log__c();
        // Set the values of fields of the Error_Log__c object
        newLogObj.Process_Name__c=processName;
        newLogObj.Log_Details__c=logDetails;
        newLogObj.Log__c=dt;
        newLogObj.Name=errorLogName;
        // Insert the newly created record into the database
        insert newLogObj;
        // Return the Id of the newly created Error_Log__c record
        return newLogObj.Id;
    }

}