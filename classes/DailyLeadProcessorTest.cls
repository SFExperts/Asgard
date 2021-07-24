@isTest
public with sharing class DailyLeadProcessorTest {
    
    @TestSetup
    static void makeData(){
        Lead lead = new Lead(firstName='first', lastName='last', Company='Black Eagle');
        integer index =0;
        List<Lead> leads  = new List<Lead>();
        while(index<200){
            Lead element = lead.clone();
            element.firstName = 'first'+index;
            leads.add(element);
            index++;
        }
        insert leads;        
    }

    @isTest
    static void testDailyLeadProcessor(){
        integer Lead_Count = 200;
        string Lead_Source =  'Dreamforce';
        System.Test.startTest();
        System.schedule('DailyLeadProcessorTest', '20 30 8 10 2 ?', new DailyLeadProcessor());
        System.Test.stopTest();
        System.assertEquals(Lead_Count, [select count() from Lead where Leadsource = :Lead_Source]);
    }  
}