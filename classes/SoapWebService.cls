global class SoapWebService{
    webService static Voter__C getVoter(Id voterId){
        Voter__C voter =  [Select Id, Name from Voter__C where Id=:voterId];
        return voter;
    }
}