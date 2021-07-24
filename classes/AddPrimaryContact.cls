public class AddPrimaryContact implements Queueable{
    private string stateCode;
    private integer recordCount = 200;
    private Contact contact;
    public AddPrimaryContact(Contact contact, String stateCode) {
        this.stateCode = stateCode;
        this.contact = contact;
    }
    public void execute(QueueableContext context){
        List<Account>accounts  = [select Id, Name from Account where BillingPostalCode =:this.stateCode Limit :recordCount];
        List<Contact> contacts =  new List<Contact>();
        for(Account acc: accounts){
            Contact contact = this.contact.clone();
            contact.AccountID=acc.ID;
            contacts.add(contact);
        }
        insert contacts;
    }
}