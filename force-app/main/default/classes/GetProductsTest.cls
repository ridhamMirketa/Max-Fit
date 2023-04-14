@isTest
private class GetProductsTest {
     @isTest static void testCallout() {
        // Set mock callout class 
       
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new GetProductsCalloutMock());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse res = GetProducts.GetAllProducts();
        
        // Verify response received contains fake values
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '[{"id":1,"title":"Hello there","Description":"Hello I am mike","price":109.5},{"id":2,"title":"Hello there ridham","Description":"Hello I am ridham","price":110.4}]';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
        
        

        GetProducts.insertProduct();
        Product2 product=[select Name from Product2 where ProductCode='1'];
        System.assertEquals('Hello there', product.Name);
        Test.stopTest();

    }
}