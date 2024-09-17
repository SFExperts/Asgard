@isTest
private class AnimalLocatorTest {
    @isTest
    public static void testAnimalLocation(){
        System.Test.setMock(System.HttpCalloutMock.class, new AnimalLocatorMock());
        String animal = AnimalLocator.getAnimalNameById(1);
        System.assert(animal!=null);
    }
}