public class LeadProcessor implements Database.Batchable<sObject>
{
    static final string LEAD_SOURCE = 'Dreamforce';
    static final string LEAD_QUERY  = 'select Id, LeadSource from Lead';

    public Database.QueryLocator start(Database.BatchableContext batchContext){
        return Database.getQueryLocator(LEAD_QUERY);        
    }
    public void execute(Database.BatchableContext context, List<Lead> scope){
        for(Lead person:scope){
            person.LeadSource = LEAD_SOURCE;
        }
        update scope;
    }

    public void finish(Database.BatchableContext context){

    }
}