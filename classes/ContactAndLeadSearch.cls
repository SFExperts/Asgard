public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String name){
        List<List<sObject>> resultSet 
            	= [Find :name in NAME FIELDS returning contact(firstname, lastname), lead(firstname, lastname)];
        return resultSet;
    }
}