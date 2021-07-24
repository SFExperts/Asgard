public with sharing class DailyLeadProcessor implements Schedulable{
    public void execute(SchedulableContext context){
        List<Lead> leads = [select Id, LeadSource from Lead where LeadSource='' limit 200];
        for(Lead lead: leads){
            lead.LeadSource = 'Dreamforce';
        }
        update leads;
    }
}