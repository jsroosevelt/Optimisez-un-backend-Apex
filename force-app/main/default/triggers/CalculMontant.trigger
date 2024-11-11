trigger CalculMontant on Order (before update) {
	AP01Account.calculNetAmount(trigger.new);
}
