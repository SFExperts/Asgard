@isTest
public class TestRestrictContactByName {
    @isTest
    static void testValidContactName(){
        Contact contact1 = new Contact(firstName='Tom', lastName='INVALIDNAME');
        Contact contact2 = new Contact(firstName='Tom', lastName='INVALIDNAME');
        List<Contact> contacts =  new List<Contact>{contact1, contact2};
        Database.SaveResult[] result = Database.Insert(contacts, false);
		Integer index =0;
        for(Database.SaveResult element: result){

            System.Assert(!element.isSuccess());
            for(Database.Error error: element.getErrors()){
                System.debug('Error > ' + index + ' : ' + error);
                index = index + 1;
            }            
        }
    }
}