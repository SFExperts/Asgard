public class BulkUpdateContacts {
    
    public List<Contact> contacts {get;set;}
    private ApexPages.StandardSetController standardController;
    private Set<Id> contactids = new Set<Id>();

    public BulkUpdateContacts(ApexPages.StandardSetController standardController){
        this.standardController = standardController;
        contacts = new List<Contact>();
        for (Contact element : (List<Contact>)standardController.getSelected()){ 
            contactids.add(element.Id);
        }
        if(contactIds.size()!=0){
	        contacts = [SELECT Id, Name FROM contact WHERE Id in: contactIds];
        }else{
            contacts = [SELECT Id, Name FROM contact];
        }
    }

}