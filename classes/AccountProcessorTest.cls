@isTest
public class AccountProcessorTest {
    
    @isTest
    public static void testCountContacts(){
        Account acc = new Account(name='Glass House');
        insert acc;
        
        Contact contact = new Contact(AccountId=acc.Id, firstName='sample', Lastname='Contact');
        insert contact;
        
        List<Id> accountIds = new List<Id>();
        accountIds.add(acc.Id);
		System.Test.startTest();
        AccountProcessor.countContacts(accountIds);
        System.Test.stopTest();
        
        Account accAgain =  [select Id, Number_of_Contacts__c from Account where Id=:acc.Id];
        System.assertEquals(1, accAgain.Number_of_Contacts__c);
        

    }

}