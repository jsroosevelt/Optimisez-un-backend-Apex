public class AP01Account {
    public static void batchUpdateChiffreAffaire(Set<Id> setAccountIds) {
            // Requête pour obtenir les comptes avec leurs commandes associées
            List<Account> accountsToUpdate = [
                SELECT Id, Chiffre_d_affaire__c, (SELECT TotalAmount FROM Orders WHERE Status = 'Ordered')
                FROM Account
                WHERE Id IN :setAccountIds
            ];

            // Mise à jour du chiffre d'affaires pour chaque compte
            for (Account acc : accountsToUpdate) {
                Decimal totalRevenue = 0;
                for (Order ord : acc.Orders) {
                    totalRevenue += ord.TotalAmount;
                }
                acc.Chiffre_d_affaire__c = totalRevenue;
            }

            // Mise à jour des comptes en base de données
            if (!accountsToUpdate.isEmpty()) {
                update accountsToUpdate;
            }
       }

       public static void batchUpdateAccount(List<Account> setAccountIds){
        // Requête pour obtenir les comptes avec leurs commandes associées
        List<Account> accountsToUpdate = [
            SELECT Id, Chiffre_d_affaire__c, (SELECT TotalAmount FROM Orders WHERE Status = 'Ordered')
            FROM Account
            WHERE Id IN :setAccountIds
        ];

        // Mise à jour du chiffre d'affaires pour chaque compte
        for (Account acc : accountsToUpdate) {
            Decimal totalRevenue = 0;
            for (Order ord : acc.Orders) {
                totalRevenue += ord.TotalAmount;
            }
            acc.Chiffre_d_affaire__c = totalRevenue;
        }

        // Mise à jour des comptes en base de données
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }

    public static void updateAccountCAffaire(List<order> orders, Map<Id, sObject> oldMap){
        List<Account> accountsToUpdate = new List<Account>();
        Map<ID, Decimal> amount = new Map<ID, Decimal>();

        for (order o: orders){
            Decimal a = o.TotalAmount - (Decimal)oldMap.get(o.ID).get('TotalAmount');
            amount.put(o.AccountId,a);
        }

        List<Account> accns = new List<Account>([SELECT ID, Chiffre_d_affaire__c FROM Account WHERE ID IN: amount.keySet()]);

        for (Account a: accns){
            Decimal oldCa = (a.chiffre_d_affaire__c!=null)?a.chiffre_d_affaire__c:0; //setting at 0 to avoid null exception after 
            Decimal ca = oldCa + amount.get(a.ID);
            a.chiffre_d_affaire__c = (ca<0)?0:ca; //no values below 0
            accountsToupdate.add(a);
        }
        update accountsToupdate;
    }

    public static void calculNetAmount(List<order> orders){
        for(integer i=0; i< orders.size(); i++){
            Order newOrder = orders[i];

            if(newOrder.TotalAmount>0){
                newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
            }
        }
    }
}
