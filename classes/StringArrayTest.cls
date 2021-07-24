public class StringArrayTest {
    public static List<String> generateStringArray(integer i){
        List<String> listTestStrings =  new List<String>();
        
        Integer x = 0;
        for(;x<i;x++) {
            listTestStrings.add('Test ' + x );
        }
        return listTestStrings;       
    }

}