global class UpdateAccounts implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator([SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')]);
    }

    global void execute(Database.BatchableContext info, List<Account> scope){      
        AP01Account.batchUpdateAccount(scope);
    }

    global void finish(Database.BatchableContext info){     
        
    } 
 }
 
