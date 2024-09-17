@isTest
private class AddPrimaryContactTest {
    @TestSetup
    static void makedata(){
        Account account = new Account(name='Account#1');
        List<Account> accounts = new List<Account>(); 
        integer index = 0;
        while(index<50){
            Account acc = account.clone();
            acc.Name =  'Account#'+ index;
            acc.BillingPostalCode = 'NY';
            accounts.add(acc);
            index++;
        }
        index =0;
        while(index<50){
            Account acc = account.clone();
            acc.Name =  'Account@'+ index;
            acc.BillingPostalCode = 'CA';
            accounts.add(acc);
            index++;
        }
        insert accounts;
    }
    @isTest
    public static void testAddPrimaryContact() {
        string billingCode = 'CA';
        Integer desiredContactCount = 50;
        System.Test.startTest();
        Contact contact = [Select Id, Name, firstName, LastName from Contact][0];
        System.enqueueJob(new AddPrimaryContact(new Contact(firstName='first', LastName='last'), billingCode));
        System.Test.stopTest();
        List<Contact> contacts = [select Id, AccountID from Contact where Account.BillingPostalCode=:billingCode];
        System.assertEquals(desiredContactCount,contacts.size());
    }
}