class MyTransaction {
  final int? id; // Optional ID for the database
  final double amount;
  final String category;
  final DateTime date;
  final String type;

  MyTransaction({
    this.id,
    required this.category,
    required this.type,
    required this.amount,
    required this.date,
  });

  // Convert Transaction to a Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'type': type,
      'date': date.toIso8601String(), // Store as ISO 8601 string
    };
  }
}
