@isTest
private class TestVerifyDate{
  static testMethod void test_CheckDates_UseCase1(){
    VerifyDate obj01 = new VerifyDate();
    VerifyDate.CheckDates(Date.today(),Date.today());
  }
  static testMethod void test_CheckDates_UseCase2(){
    VerifyDate obj01 = new VerifyDate();
    VerifyDate.CheckDates(Date.today().addDays(2), Date.today());
  }

   static testMethod void test_DateWithin30Days_UseCase1(){
    VerifyDate obj01 = new VerifyDate();
    VerifyDate.DateWithin30Days(Date.today(),Date.today());
  }
  static testMethod void test_SetEndOfMonthDate_UseCase1(){
    VerifyDate obj01 = new VerifyDate();
    VerifyDate.SetEndOfMonthDate(Date.today());
  }
}