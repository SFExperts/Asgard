public class NewCaseListController {
    public string status{get;set;}
    public List<Case> cases{get;set;}
    
    public NewCaseListController(){
	    this.cases = [Select Id, Status, Description, caseNumber from Case];
        Contact element = [Select Id from Contact Limit 1];
		String id = getContact().Account?.Id;

    }
    
    private Contact getContact(){
        return [Select Id from Contact Limit 1];
    }
    
    public void setStatusToNew(){
		status = 'new'; 
        getCasesOne();
    }
    public void setStatusToAll(){
        status = '';
        getCasesOne();
    }
	
    public List<Case> getNewCases (){
        return [Select Id, Status, Description, caseNumber from Case where status='New'];
    }
    
    public void getCasesOne(){
        if(status==''){
	        this.cases = [Select Id, Status, Description, caseNumber from Case];
        }
        else{
	        this.cases = [Select Id, Status, Description, caseNumber from Case where status=:status];        
        }
    }
    
    
}