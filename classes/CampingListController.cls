public  with sharing class CampingListController {
    @AuraEnabled
    public static List<Camping_Item__c> getItems() {
        List<Camping_Item__c> existingCampingList =  [select name, price__c, Quantity__c, Packed__c from Camping_Item__c];     
        return existingCampingList;
    }
    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c campingItem){
        System.debug('CampingItem' + campingItem);
        System.debug('CampingItem Name	' + campingItem.Name);
        upsert campingItem;
        return campingItem;
    }

}