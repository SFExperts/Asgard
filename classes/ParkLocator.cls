public class ParkLocator {
	public static List<String> country(String country){
    	ParkService.ParksImplPort parksPort = new Parkservice.ParksImplPort();
        List<String> parks  = parksPort.byCountry(country);
		return parks;
    }
}