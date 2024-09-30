class Transaction {

  String type;
  String catagory;
  double amount;
  DateTime date;
 
  Transaction({
    required this.catagory,
    required this.type,
    required this.amount,
    required this.date, required String category,
  });
}