class Transactions {
  final int? keyID;
  final String title;
  final int amount;
  final DateTime date;
  final String detail;
  final String name;
 
  Transactions({
    this.keyID,
    required this.title,
    required this.amount,
    required this.date,
    required this.detail,
    required this.name,
  });
}