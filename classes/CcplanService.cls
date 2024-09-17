public class CcplanService {
    public static decimal findCapacity(decimal fairsize){
        return 1;
    }
    public static warehousecapacity__c getCapacity(bookfair__c fair){
        warehousecapacity__c house;
        return house;
    }
    
    public static boolean updateCapacity(List<bookfair__c> newBF, Map<Id, bookfair__c> oldBF){
        List<warehousecapacity__c> capacities  =  new List<warehousecapacity__c>();
        for(bookfair__c fair: newBF){
            boolean added 							= false;
            decimal fairsizeold 					= oldBF.get(fair.Id).fairsize__c; // Or $ amount.
            decimal fairsizenew 					= fair.fairsize__c;
            warehousecapacity__c currentCapacity 	= CcplanService.getCapacity(fair); // to do.
            decimal CCcurrent 						= currentCapacity.Consumed_Capacity__c;
            
            // CHANGE: FAIR SIZE 
            if(!(fairsizenew == fairsizeold)){
                currentCapacity.Consumed_Capacity__c = getConsumedCapacity(CCcurrent,fairsizeold,fairsizenew);                
                capacities.add(currentCapacity);
                added = true;
            }
            // CHANGE: FAIR DATES
            Date fairDateB_new;
            Date fairDateB_old;            
            if(!(fairDateB_new == fairDateB_old)){
                currentCapacity.Consumed_Capacity__c = getConsumedCapacity(CCcurrent,fairsizeold,0);                
                if(!added){
                    capacities.add(currentCapacity);
                }
                warehousecapacity__c newCapacityObject; // to to - get capacity object based off fair start date.
                newCapacityObject.Consumed_Capacity__c = getConsumedCapacity(newCapacityObject.Consumed_Capacity__c, 0,fairsizenew);
                capacities.add(newCapacityObject);
                
            }
            
   		}
		return true;        
    }
    // consumed capacity
    static decimal getConsumedCapacity(decimal CCcurrent, decimal fairsizeold, decimal fairsizenew){
        decimal CapBFold = CcplanService.findCapacity(fairsizeold); // based on farmula.
        decimal CapBFnew = CcplanService.findCapacity(fairsizenew);
        decimal CapConsnew = CCcurrent - CapBFnew + CapBFold; // Recover old BF capacity and remove new BF capacity.
        return CapConsnew;              
    }
               
}