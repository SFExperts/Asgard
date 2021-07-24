@isTest
private class TemperatureConverterTest {
    
    static testmethod void testWarmTemp() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(70);
        System.assertEquals(21.11,celsius);
    }
    
    static testmethod void testFreezingPoint() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(32);
        System.assertEquals(0,celsius);
    }
    static testmethod void testBoilingPoint() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(212);        
        System.assertEquals(100,celsius,'Boiling point temperature is not expected.');
    } 
    
    static testmethod void testNegativeTemp() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(-10);
        System.assertEquals(-23.33,celsius);
    }
      
}