@isTest
public class AccountManagerTest {
    @isTest
    public static void testGetAccount()
    {
        Account aRecord = createTestRecord();
		RestRequest request  = new RestRequest();
        request.requestURI = 
	   'https://adityaincanada-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
		+ aRecord.Id + '/contacts';          
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account acc =  AccountManager.getAccount();
        System.assertEquals(aRecord.name, acc.name );

    }
    static Account createTestRecord(){
        Account acc =  new Account(Name='Grand-Hotels');
        Insert acc;
        return acc;
    }
}