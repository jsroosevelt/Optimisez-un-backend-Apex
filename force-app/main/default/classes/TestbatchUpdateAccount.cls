@isTest
private class TestbatchUpdateAccount {
    @TestSetup
    static void makeData(){
        TestDataFactory.createAccounts(200);
    }
    @isTest
    public static void test(){
        Test.startTest();

        // select the batch to test
        //List<Account> accns = new List<Account>([SELECT ID FROM Account WHERE Name LIKE 'testAccount%']);
        UpdateAccounts batch = new UpdateAccounts();

        Id batchId = Database.executeBatch(batch);
        Test.stopTest();
        List<Account> result = [SELECT ID, Chiffre_d_affaire__c FROM Account WHERE ID IN (SELECT AccountID FROM Order WHERE Status = 'Ordered')];

        for(Account a: result){ // making sure that all accounts have an updated CA
            System.assertEquals(21500, a.Chiffre_d_affaire__c);
        }
   }
}
