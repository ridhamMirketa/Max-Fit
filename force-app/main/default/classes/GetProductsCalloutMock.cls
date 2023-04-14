@isTest
global class GetProductsCalloutMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"id":1,"title":"Hello there","Description":"Hello I am mike","price":109.5},{"id":2,"title":"Hello there ridham","Description":"Hello I am ridham","price":110.4}]');
        response.setStatusCode(200);
        return response; 
    }
}