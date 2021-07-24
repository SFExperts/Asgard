public with sharing class GetAllOpportunities {
   @AuraEnabled(cacheable=true)
    public static List<Opportunity> getAllOpps() {
        List<Opportunity> results = [SELECT Id, Name ,StageName, CloseDate ,Type ,Probability,Account.Name from Opportunity];
        List<Opportunity> updatedresults = new List<Opportunity>(results);
        
        for(Opportunity record: updatedresults){
            record.Name = record.Name + 'Test';
        }
        return updatedresults;
        
    }
}