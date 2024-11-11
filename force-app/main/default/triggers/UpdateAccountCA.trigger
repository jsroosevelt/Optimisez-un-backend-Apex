trigger UpdateAccountCA on Order (after update) {
	
    set<Id> setAccountIds = new set<Id>();

    AP01Account.updateAccountCAffaire(trigger.new, trigger.oldMap);
}
