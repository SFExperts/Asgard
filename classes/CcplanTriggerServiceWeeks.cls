public class CcplanTriggerServiceWeeks {
	static public boolean postinsert(warehouse__c house){        
        return addcapacity(house);                
    }
    
    static boolean addcapacity(warehouse__c house){
        boolean response = true;
        try{            
        	FiscalYear fiscalYear = new FiscalYear(Date.today().year()-1, Date.today().year());
        	List<Warehouse_Week__c> scope = CcplanBatchserviceWeeks.makeListWeeks(fiscalYear);	        
            upsert scope Name;
    	    List<warehousecapacity__c> wcapacityList = new List<warehousecapacity__c>();
        	for(Warehouse_Week__c week: scope){
        		wcapacityList.add(CcplanBatchserviceWeeks.newcapacity(house, week,0,house.name + '-' + week.name ));
        	}
 			upsert wcapacityList;
        } catch(Exception ex){
            system.debug('in exception: '+ ex.getLineNumber());
            response = false;
        }
        return response;        
    }    
}