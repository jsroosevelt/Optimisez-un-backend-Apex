public without sharing class MyTeamOrdersController {
    public List<Order> orders { get; set; }

    public MyTeamOrdersController() {
        orders = [
            SELECT CreatedById, EffectiveDate, Status, TotalAmount 
            FROM Order
        ];
    }

    public decimal SumOders{
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
			return (decimal)groupedResults.get('total');
        }
        set;
    }
}
