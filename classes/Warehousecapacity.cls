public with sharing class Warehousecapacity {
    /*
* Return list of warehouses -  each element with it's own list of capacities.
*/
    @AuraEnabled(cacheable=true)
    public static List<warehouse__c> getCapacity(string yearid, string quarterid, string warehouseid) {
        List<warehouse__c> warehouses;
        try{
            if(warehouseid!=null && warehouseid.equals('ALL')){
                warehouses =  [SELECT Id, Name, 
                               (select Id, capacity__c, 
                                warehouseweek__r.Id,warehouseweek__r.name,warehouseweek__r.weekstartdate__c                              
                                from warehousecapacity__r // Important.
                                where warehouseweek__r.Fiscal_Year_Start__c= :getStartYear(yearid) and
                                warehouseweek__r.quarter__c=:getQuarter(quarterid)) 
                               from warehouse__c ];
            } else {
                warehouses =  [SELECT Id, Name, 
                               (select Id, capacity__c, 
                                warehouseweek__r.Id,warehouseweek__r.name,warehouseweek__r.weekstartdate__c                              
                                from warehousecapacity__r // Important.
                                where warehouseweek__r.Fiscal_Year_Start__c= :getStartYear(yearid) and
                                warehouseweek__r.quarter__c=:getQuarter(quarterid)) 
                               from warehouse__c
                               where Id=:warehouseid];
            }
        } catch(Exception ex){
            throw new AuraHandledException(ex.getMessage());
        }
        return warehouses;       
    }
    
    @AuraEnabled(cacheable=true)
    public static List<warehousecapacity__c> getWeeklyCapacity(string capacityId) {
        system.debug('capacity id: ' +  capacityId);
        
        List<warehousecapacity__c> results = new List<warehousecapacity__c>();
        if('ALL'.equals(capacityId) || capacityId == null){
            results  =  [SELECT Id, Name, warehouse__r.name, capacity__c from warehousecapacity__c];
        } else if(capacityId != null){
            results = [SELECT Id, Name, warehouse__r.name, capacity__c from warehousecapacity__c where id=:capacityId];
        }
        // For future use.
        List<warehousecapacity__c> updatedresults = new List<warehousecapacity__c>(results);
        
        for(warehousecapacity__c record: updatedresults){
            record.Name = '[' + record.Name + ']';
        }
        return results;
        
    }
    
    
    // not in use.
    @AuraEnabled(cacheable=true)
    public static List<Warehouse_Week__c> getWeeks(string quarterid){
        
        system.debug('in getWeeks: ' + quarterid);
        List<Warehouse_Week__c> weeks  = [select id, name from Warehouse_Week__c];
        system.debug('weeks:' + weeks);
        return weeks;
    } 
    
    @AuraEnabled(cacheable=true)
    public static string getJsonWeeks(string fiscalyearid, string quarterid){
        system.debug('in getWeeks: ' + quarterid);
        decimal quarterposition =  getQuarter(quarterid);
        decimal startyear  = getStartYear(fiscalyearid);
        List<Warehouse_Week__c> weeks  = [select id, name, weekstartdate__c from Warehouse_Week__c 
                                          where 
                                          fiscal_Year_Start__c=:startyear and 
                                          quarter__c=:quarterposition                                      
                                          order by weekstartdate__c];
        
        
        List<CustomWeek> customweeks  = new List<customWeek>();
        for(Warehouse_Week__c week:weeks){
            customweek cweek =  new customweek(week.id, week.name, week.weekstartdate__c);
            customweeks.add(cweek);
        }
        string serializedjson =  Json.serialize(customweeks);
        system.debug('serializedjson: ' + serializedjson);
        return Json.serialize(customweeks);
    } 
    
    
    @AuraEnabled(cacheable=true)
    
    public static string getallcapacities(string yearid, string quarterid, string warehouseid) {
        //string warehouseId = 'a0L0b00000V6S4wEAF';
        if(warehouseid==null){
            warehouseId = 'ALL';
        }
        
        List<Map<string, string>> capacities = new List<Map<string, string>>();
        List<warehousecapacity__c> results;
        
        decimal Qstartyear  =  getStartYear(yearid);
        decimal Qquarter    =  getQuarter(quarterid);
        
        
        string querySelect = 
            'SELECT id, name, warehouseweek__r.Id,warehouseweek__r.position__c, warehouseweek__r.weekstartdate__c,' + 
            'warehouseweek__r.week_end_date__c,warehouseweek__r.fiscal_year_start__c,warehouseweek__r.fiscal_year_end__c,'+
            'warehouse__r.Id, warehouse__r.name, capacity__c, consumed_capacity__c from warehousecapacity__c';
        
        string queryWhere = 
            ' where warehouseweek__r.fiscal_year_start__c=:Qstartyear and warehouseweek__r.quarter__c=:Qquarter'; 
        if(!'ALL'.equals(warehouseId)){
            queryWhere = queryWhere + ' and warehouse__r.Id=:warehouseId';
        }
        
        string queryOrder = ' order by warehouseweek__r.position__c';
        
        string capacityQuery = querySelect + queryWhere + queryOrder;
        
        system.debug('capacityQuery: ' + capacityQuery);
        
        results  =  Database.query(capacityQuery);
        
        for(warehousecapacity__c row: results){
            Map<string,string> capacityRow =  new Map<string,string>();
            capacityRow.put('Id', row.Id);
            capacityRow.put('position', row.warehouseweek__r.position__c+'');
            capacityRow.put('cap_name', row.Name);
            capacityRow.put('ware_name', row.warehouse__r.name);
            capacityRow.put('cap_max', row.capacity__c+'');
            capacityRow.put('cap_consumed', row.Consumed_Capacity__c+'');
            capacityRow.put('score', row.Consumed_Capacity__c+'/'+row.capacity__c);            
            capacityRow.put('status', status(row.warehouseweek__r.position__c, row.capacity__c)); // temporary.
            capacityRow.put('startdate', row.Warehouseweek__r.weekstartdate__c + '');
            capacityRow.put('enddate', row.Warehouseweek__r.week_end_date__c + '');
            capacityRow.put('daterange', (row.Warehouseweek__r.weekstartdate__c).format() + ' - ' + row.Warehouseweek__r.week_end_date__c + '');
            
            capacities.add(capacityRow);
        }        
        return Json.serialize(capacities);
        
    }
    
    static string status_open = 'open';
    static string status_partial = 'partial';
    static string status_close = 'close';
    
    static string status (Decimal consumed, Decimal max){
        if(math.Mod((integer)consumed, 2)==0){
            return status_open;
        }
        else{
            return status_close;
        }
        
        /*
string status = status_open;
decimal availratio =  consumed/max;

if(consumed == null || max == null || max == 0 || consumed == 0){
availratio = 1;
}

if(availratio>.75){
status   = status_open;
} else if(availratio>.50){
status   = status_partial;
} else{
status = status_close;
} 
return status;       
*/
    }
    
    @AuraEnabled(cacheable=true)
    public static List<financialyear__c> getallfiscalyears() {
        List<financialyear__c> results  =  [SELECT id, name, startyear__c, lastyear__c from financialyear__c order by startyear__c];       
        return results;        
    }
    
    @AuraEnabled(cacheable=true)
    public static List<yearquarter__c> getallquarters() {
        List<yearquarter__c> results  =  [SELECT id, name,position__c from yearquarter__c order by position__c];       
        return results;        
    }
    
    @AuraEnabled(cacheable=true)
    public static List<warehouse__c> getAllWarehouses(){
        return [SELECT id, name from warehouse__c order by name];       
    }
    
    private static decimal getQuarter(string quarterid){
        return  [select position__c from yearquarter__c where Id=:quarterid].position__c;        
    }
    
    private static decimal getStartYear(string fiscalyearid){
        return [select Id, startyear__c from FinancialYear__c where id=:fiscalyearid].startyear__c;
    }    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [SELECT Id, FirstName, LastName, Title, Phone, Email FROM Contact LIMIT 10];
    }
    
    @AuraEnabled(cacheable=true)
    public static string filters(){        
        Map<string, List<sObject>> filters =  new Map<string, List<sObject>>();
        filters.put('years', getallfiscalyears());
        filters.put('quarters', getallquarters());
        filters.put('warehouses', getAllWarehouses());
        return Json.serialize(filters);
    }
}