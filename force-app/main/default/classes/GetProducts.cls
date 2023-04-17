public with sharing class GetProducts {
    public static HttpResponse GetAllProducts() {
        //Making a custom pricebook method
        try{
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://fakestoreapi.com/products');
            request.setMethod('GET');

            Http http = new Http();
            HttpResponse response = http.send(request);
            return response;
        }catch(Exception e){
            System.debug(e);
            return null;
        }
        
    }
    public static void insertProduct(){
        Id standardPriceBookId;
        HttpResponse response=GetAllProducts();
        if (response.getStatusCode() == 200) {
            if(test.isRunningTest()){
                 standardPriceBookId=test.getStandardPricebookId();
            }else{
                Pricebook2 standardPriceBook= [select id from Pricebook2 where IsStandard=true];
                 standardPriceBookId=standardPriceBook.id;
            }
            
            
            Pricebook2 priceBook=new Pricebook2();
         	priceBook.Name='ridhamgodha-pricebook';
         	insert priceBook;
            // Successfully retrieved data
            String responseJson = response.getBody();
            List<object> lProducts=(List<Object>)JSON.deserializeUntyped(responseJson);
            List<Id> insertedProductId=new List<Id>();
            List<Product2> lProductObj=new List<Product2>();
            Map<String,Decimal> priceIdMap=new Map<String,Decimal>();
            for(object product:lProducts){
                Map<String, Object> jsonObj = (Map<String, Object>)product;
                ProductModelClass obj=new ProductModelClass(jsonObj);
                String id = obj.getId();
                String title = obj.gettitle();
                String description = obj.getdescription();
                Decimal price = obj.getPrice();
                
                priceIdMap.put(id, price);
                
                Product2 newProduct=new Product2(ProductCode=id,Name=title,Description=description);
                lProductObj.add(newProduct);
               
            }
            
            insert lProductObj;
            
            for(Product2 Product:lProductObj){
                insertedProductId.add(Product.id);
            }
           
            Map<Id,Product2> newMap=new Map<Id,Product2>([select id,ProductCode from Product2 where id in:insertedProductId]);
            List<PricebookEntry> lPriceBookEntry=new List<PricebookEntry>();
            List<PricebookEntry> lStandardPriceBookEntry=new List<PricebookEntry>();
            for(Id key: newMap.keySet()){

                Decimal productPrice=priceIdMap.get(newMap.get(key).ProductCode);
                PricebookEntry newStandardPriceBookEntry=new PricebookEntry(UnitPrice=productPrice,Product2Id=key,Pricebook2Id=standardPriceBookId,IsActive=true);
                PricebookEntry newPriceBookEntry=new PricebookEntry(UnitPrice=productPrice,Product2Id=key,Pricebook2Id=priceBook.id,IsActive=true);
                lPriceBookEntry.add(newPriceBookEntry);
                lStandardPriceBookEntry.add(newStandardPriceBookEntry);
            
            }
            
            insert lStandardPriceBookEntry; 
            insert lPriceBookEntry;
            
        } else {
            // Handle error response
            String error = 'Failed with status: ' + response.getStatusCode() + ' ' + response.getStatus();
            System.debug(error);
        }
    }
}