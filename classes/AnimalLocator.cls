public class AnimalLocator {
    
    public static string getAnimalNameById(integer id){
		string name  = null;
        string url =  'https://th-apex-http-callout.herokuapp.com/animals/';
        HttpRequest request  = new HttpRequest();
        request.setEndpoint(url+id);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = new Http().send(request);
        if(response.getStatusCode()==200){
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
			Object animalObj = results.get('animal');
            String animalStr = response.getBody();
            System.debug('animalstr:  ' + animalStr);
            JSON2Apex r = JSON2Apex.parse(animalStr);
            System.debug('Printing animal: ' + r.animal);
            name  = r.animal.name;
        }
        return name;
    }
}