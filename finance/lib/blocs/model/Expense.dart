class Expense {
  final int id;
  final String userId;
  final String title;
  final String cost;
  final String description = '';
  final String date;

  const Expense({
    required this.id,
    required this.userId,
    required this.title,
    required this.cost,
    required this.date
  });


    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'cost': cost,
      'date': date
    };
    }

  @override
  String toString() {
    return 'Dog{id: $id, userId: $userId, title: $title, cost:$cost, date:$date}';
  }
}