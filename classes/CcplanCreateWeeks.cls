global class CcplanCreateWeeks implements Database.Batchable<warehouse_week__c> {
    
    global Iterable<warehouse_week__c> start(Database.BatchableContext bc) {
        //Current Year
        //FiscalYear fiscalYear = new FiscalYear(Date.today().year(), Date.today().year()+1);
        // Previous year
        FiscalYear fiscalYear = new FiscalYear(Date.today().year()-1, Date.today().year());
        return CcplanBatchserviceWeeks.makeListWeeks(fiscalYear);
    }
     
    global void execute(Database.BatchableContext bc, List<Warehouse_Week__c> scope){
        upsert scope Name;
        // For each warehouse - create capacityweeks for all weeks. 
        List<warehousecapacity__c> wcapacityList = new List<warehousecapacity__c>();
        List<warehouse__c> warehouses = [select Id,Name from warehouse__c];
        for(warehouse__c warehouse: warehouses){
            for(Warehouse_Week__c week: scope){
                wcapacityList.add(CcplanBatchserviceWeeks.newcapacity(warehouse, week,0,warehouse.name + '-' + week.name ));
            }
        }
        system.debug('wcapacityList size' + wcapacityList.size());
        system.debug('wcapacityList: ' + wcapacityList);
        upsert wcapacityList;        
    }

   
    
    global void finish(Database.BatchableContext bc){        
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
                            JobItemsProcessed,
                            TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id = :bc.getJobId()];        
    }    
    
   
}