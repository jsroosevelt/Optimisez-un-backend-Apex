@istest
class TestScheduledApex {

   static testmethod void test() {
   Test.startTest();
      // Schedule the test job

      String jobId = System.schedule('TestBasicScheduledApex',
      ScheduledApexFromTestMethod.CRON_EXP, 
         new ScheduledApexFromTestMethod());

      // Get the information from the CronTrigger API object
      CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
         NextFireTime
         FROM CronTrigger WHERE id = :jobId];

      // Verify the expressions are the same
      System.assertEquals(ScheduledApexFromTestMethod.CRON_EXP, 
         ct.CronExpression);

      // Verify the job has not run
      System.assertEquals(0, ct.TimesTriggered);

      //generate the next monday
        Date currentDatetime = Date.today();
        Date startOfWeek = currentDatetime.toStartOfWeek();
        Datetime nextMondayDatetime = startOfWeek.addDays(6);

        // set hour
        nextMondayDatetime = Datetime.newInstance(nextMondayDatetime.year(), nextMondayDatetime.month(), nextMondayDatetime.day());

        // Format date
        String formattedNextMonday = nextMondayDatetime.format('yyyy-MM-dd HH:mm:ss');

      System.assertEquals(formattedNextMonday, String.valueOf(ct.NextFireTime));

   Test.stopTest();
   }
}