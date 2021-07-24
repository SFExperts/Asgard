@isTest
public class AnimalsCalloutsTest {
    @isTest
    static void testGetCallOut(){
		StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
		mock.setStaticResource('myStaticResourceName');
		mock.setStatusCode(200);
		mock.setHeader('Content-Type', 'application/json');
        System.Test.setMock(HttpCalloutMock.class, mock);
        
    }

}