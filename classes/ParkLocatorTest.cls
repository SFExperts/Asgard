@isTest
public class ParkLocatorTest {
    @isTest
    public static void testCountry(){
		System.Test.setMock(WebServiceMock.class, new ParkServiceMock());
        List<String> parks  = ParkLocator.country('India');
        System.assert(parks.size()==3);
    }
}