public class CustomWeek {
    public Id id{get; set;}
    public string name{get; set;}
    public date weekstartdate{get;set;}
        
        public CustomWeek(Id id, string name, Date weekstartdate){
            this.id= id;
            this.name=  name;
            this.weekstartdate = weekstartdate;
        }

}