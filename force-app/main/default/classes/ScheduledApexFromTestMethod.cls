global class ScheduledApexFromTestMethod implements Schedulable {

    // This test runs a scheduled job at midnight

       public static String CRON_EXP = '0 0 0 ? * 1';

       global void execute(SchedulableContext ctx) {
          CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                    FROM CronTrigger WHERE Id = :ctx.getTriggerId()];

          UpdateAccounts batch = new UpdateAccounts();
          Database.executeBatch(batch);
       }
    }