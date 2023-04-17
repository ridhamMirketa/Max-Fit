public with sharing class ProductModelClass{

     public Map<String, Object> obj;
    
     public ProductModelClass(Map<String, Object> obj) {
    
     this.obj = obj;
    
    }
    
    public String getId() {
        Integer id=(Integer)obj.get('id');
        String id1=String.valueOf(id);
        return id1;
    }
    public String getTitle() {
        return (String)obj.get('title');
    }
    public String getDescription() {
        return (String)obj.get('description');
    }
    public Decimal getPrice() {
        return (Decimal)obj.get('price');
    }
        
}