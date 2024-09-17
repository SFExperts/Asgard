@isTest
private with sharing class LeadProcessorTest {

    static final Integer leadsCount = 200;

    @TestSetup
    static void createContacts(){
        Integer index = 0;
        List<Lead> leads =  new List<Lead>();
        while(index <leadsCount){
            string firstName = 'Nick'+ index;
            string lastName = 'Fury '+ index;
            leads.add(new Lead(firstname = firstName, lastname = lastName, Company='Sunshine'));
            index++;
        }
        insert leads;
    }

    @isTest
    public static void testLeadProcessor(){
        System.Test.startTest();
        Id batchId = Database.executeBatch(new LeadProcessor());
        System.Test.stopTest();
        System.assertEquals(200, [Select count() from Lead where LeadSource ='Dreamforce']);
    }
}